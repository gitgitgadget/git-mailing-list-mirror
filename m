From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 09/19] index-helper: add Windows support
Date: Wed, 16 Mar 2016 18:42:54 +0700
Message-ID: <CACsJy8DSORe6chXkufJB8ZYxi0kG6dUUbW_Spb=60bcxETasLQ@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com> <1457548582-28302-10-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:43:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag9rP-0005wU-N8
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 12:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932951AbcCPLn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2016 07:43:28 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34373 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932347AbcCPLn0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 07:43:26 -0400
Received: by mail-lf0-f41.google.com with SMTP id e138so16378711lfe.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u4ZNQQshujs5rZedJ4vjyGxuCCDfbrsm/JW8tzb6p94=;
        b=WadKIBsabYtb2Zg+loKssXK4efZX8/cg8x+QQZLXgje9QOfbcVQ2baTYqqTf0jnlAk
         +gTNtmEiNnQ1/SY6FeYVkwA1acXQUXxMi33dsGiugEpsTghAE7Br3NsCfKNB4eJ1Oxy9
         dCN6B16aiJHNsfGCf2VAnrN4B4gVbsDKnvppVWPddjRPFjC19hMGm/kzi9UbjmfiyMBD
         D3sHfkOReCYz0zXAPBOlf8pbfqGA2bwcJy5A4Yw/NrOdP2+9oO7KqtinMNW6uQmd3N50
         kz07bLeF6IjHu7aQo34FknL4ypX5QUHX+acpPxB6W5R+OB1LWX61hcpcCNCe9xQwkoF0
         Z41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u4ZNQQshujs5rZedJ4vjyGxuCCDfbrsm/JW8tzb6p94=;
        b=Mf6M131nsFvV70A+GWppRdgF9W4WH7w+l1knyQzmt4uFQAG2cm5kLJgePuUn9d1Ocd
         P69gcijrqElWdBOs33RlwzzjiwM5MhajEhFq9PbihSgXHWCy/B/3qKyhgUwX1op7BtKj
         Nw7oWirk0EuiCNPl2onCWLa1BGW5BDhNs1Gl2W3b5tN19GkFzGu9MFnSk+Nhx0JAhB5N
         tuKRwRMjwg2e1Le5DDGTpJlGJVcq+gvgunG9a6+bP8us1EfXdgT0KyJI1YCmS8LKqF4f
         vdM2g6JHr6LsN0YdAAEE9hSFfnCfPxDGMrf4I+zIJrd9czlnC+Ml5wpsR6UA1MdFfssI
         2sJw==
X-Gm-Message-State: AD7BkJJJL4k7hR+AJm7I/mSpq19czhDvkV/vIRfa1+3lEcW2PnbhXqdcsVPc2uk7LsvnTpQ7EeX3o1YM17DUYw==
X-Received: by 10.25.23.94 with SMTP id n91mr972120lfi.3.1458128604927; Wed,
 16 Mar 2016 04:43:24 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 16 Mar 2016 04:42:54 -0700 (PDT)
In-Reply-To: <1457548582-28302-10-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288960>

I think it's safe to drop this patch now. It's mostly to prove that it
could work on Windows. But I don't think it's tested a lot (even I
only occasionally test it under wine).

On Thu, Mar 10, 2016 at 1:36 AM, David Turner <dturner@twopensource.com=
> wrote:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> Windows supports shared memory, but the semantics is a bit different
> than POSIX shm. The most noticeable thing is there's no way to get th=
e
> shared memory's size by the reader, and wrapping fstat to do that
> would be hell. So the shm size is added near the end, hidden away fro=
m
> shm users (storing it in headers would cause more problems with munma=
p,
> storing it as a separate shm is even worse).
>
> PostMessage is used instead of UNIX signals for
> notification. Lightweight (at least code-wise) on the client side.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  config.mak.uname |  2 ++
>  index-helper.c   | 48 ++++++++++++++++++++++++++++
>  read-cache.c     | 13 ++++++++
>  shm.c            | 96 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  4 files changed, 159 insertions(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index b5108e1..49320c7 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -394,6 +394,7 @@ ifndef DEBUG
>  else
>         BASIC_CFLAGS +=3D -Zi -MDd
>  endif
> +       PROGRAM_OBJS +=3D index-helper.o
>         X =3D .exe
>  endif
>  ifeq ($(uname_S),Interix)
> @@ -574,6 +575,7 @@ else
>                 NO_CURL =3D YesPlease
>         endif
>  endif
> +       PROGRAM_OBJS +=3D index-helper.o
>  endif
>  ifeq ($(uname_S),QNX)
>         COMPAT_CFLAGS +=3D -DSA_RESTART=3D0
> diff --git a/index-helper.c b/index-helper.c
> index 4dd9656..cf26da7 100644
> --- a/index-helper.c
> +++ b/index-helper.c
> @@ -155,6 +155,51 @@ static void loop(const char *pid_file, int idle_=
in_seconds)
>                 ; /* do nothing, all is handled by signal handlers al=
ready */
>  }
>
> +#elif defined(GIT_WINDOWS_NATIVE)
> +
> +static void loop(const char *pid_file, int idle_in_seconds)
> +{
> +       HWND hwnd;
> +       UINT_PTR timer =3D 0;
> +       MSG msg;
> +       HINSTANCE hinst =3D GetModuleHandle(NULL);
> +       WNDCLASS wc;
> +
> +       /*
> +        * Emulate UNIX signals by sending WM_USER+x to a
> +        * window. Register window class and create a new window to
> +        * catch these messages.
> +        */
> +       memset(&wc, 0, sizeof(wc));
> +       wc.lpfnWndProc   =3D DefWindowProc;
> +       wc.hInstance     =3D hinst;
> +       wc.lpszClassName =3D "git-index-helper";
> +       if (!RegisterClass(&wc))
> +               die_errno(_("could not register new window class"));
> +
> +       hwnd =3D CreateWindow("git-index-helper", pid_file,
> +                           0, 0, 0, 1, 1, NULL, NULL, hinst, NULL);
> +       if (!hwnd)
> +               die_errno(_("could not register new window"));
> +
> +       refresh(0);
> +       while (1) {
> +               timer =3D SetTimer(hwnd, timer, idle_in_seconds * 100=
0, NULL);
> +               if (!timer)
> +                       die(_("no timer!"));
> +               if (!GetMessage(&msg, hwnd, 0, 0) || msg.message =3D=3D=
 WM_TIMER)
> +                       break;
> +               switch (msg.message) {
> +               case WM_USER:
> +                       refresh(0);
> +                       break;
> +               default:
> +                       /* just reset the timer */
> +                       break;
> +               }
> +       }
> +}
> +
>  #else
>
>  static void loop(const char *pid_file, int idle_in_seconds)
> @@ -198,6 +243,9 @@ int main(int argc, char **argv)
>         fd =3D hold_lock_file_for_update(&lock,
>                                        git_path("index-helper.pid"),
>                                        LOCK_DIE_ON_ERROR);
> +#ifdef GIT_WINDOWS_NATIVE
> +       strbuf_addstr(&sb, "HWND");
> +#endif
>         strbuf_addf(&sb, "%" PRIuMAX, (uintmax_t) getpid());
>         write_in_full(fd, sb.buf, sb.len);
>         commit_lock_file(&lock);
> diff --git a/read-cache.c b/read-cache.c
> index 1a0ab0c..16fbdf6 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1546,6 +1546,18 @@ static void post_read_index_from(struct index_=
state *istate)
>         tweak_untracked_cache(istate);
>  }
>
> +#if defined(GIT_WINDOWS_NATIVE)
> +static void do_poke(struct strbuf *sb, int refresh_cache)
> +{
> +       HWND hwnd;
> +       if (!starts_with(sb->buf, "HWND"))
> +               return;
> +       hwnd =3D FindWindow("git-index-helper", sb->buf);
> +       if (!hwnd)
> +               return;
> +       PostMessage(hwnd, refresh_cache ? WM_USER : WM_USER + 1, 0, 0=
);
> +}
> +#else
>  static void do_poke(struct strbuf *sb, int refresh_cache)
>  {
>         char    *start =3D sb->buf;
> @@ -1555,6 +1567,7 @@ static void do_poke(struct strbuf *sb, int refr=
esh_cache)
>                 return;
>         kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
>  }
> +#endif
>
>  static void poke_daemon(struct index_state *istate,
>                         const struct stat *st, int refresh_cache)
> diff --git a/shm.c b/shm.c
> index 4ec1a00..04d8a35 100644
> --- a/shm.c
> +++ b/shm.c
> @@ -52,6 +52,102 @@ void git_shm_unlink(const char *fmt, ...)
>         shm_unlink(path);
>  }
>
> +#elif defined(GIT_WINDOWS_NATIVE)
> +
> +#define SHM_PATH_LEN 82        /* a little bit longer than POSIX bec=
ause of "Local\\" */
> +
> +static ssize_t create_shm_map(int oflag, int perm, ssize_t length,
> +                             void **mmap, int prot, int flags,
> +                             const char *path, unsigned long page_si=
ze)
> +{
> +       size_t real_length;
> +       void *last_page;
> +       HANDLE h;
> +
> +       assert(perm   =3D=3D 0700);
> +       assert(oflag  =3D=3D (O_CREAT | O_EXCL | O_RDWR));
> +       assert(prot   =3D=3D (PROT_READ | PROT_WRITE));
> +       assert(flags  =3D=3D MAP_SHARED);
> +       assert(length >=3D 0);
> +
> +       real_length =3D length;
> +       if (real_length % page_size)
> +               real_length +=3D page_size - (real_length % page_size=
);
> +       real_length +=3D page_size;
> +       h =3D CreateFileMapping(INVALID_HANDLE_VALUE, NULL, PAGE_READ=
WRITE, 0,
> +                             real_length, path);
> +       if (!h)
> +               return -1;
> +       *mmap =3D MapViewOfFile(h, FILE_MAP_ALL_ACCESS, 0, 0, real_le=
ngth);
> +       CloseHandle(h);
> +       if (!*mmap)
> +               return -1;
> +       last_page =3D (unsigned char *)*mmap + real_length - page_siz=
e;
> +       *(unsigned long *)last_page =3D length;
> +       return length;
> +}
> +
> +static ssize_t open_shm_map(int oflag, int perm, ssize_t length, voi=
d **mmap,
> +                           int prot, int flags, const char *path,
> +                           unsigned long page_size)
> +{
> +       void *last_page;
> +       HANDLE h;
> +
> +       assert(perm   =3D=3D 0700);
> +       assert(oflag  =3D=3D O_RDONLY);
> +       assert(prot   =3D=3D PROT_READ);
> +       assert(flags  =3D=3D MAP_SHARED);
> +       assert(length <=3D 0);
> +
> +       h =3D OpenFileMapping(FILE_MAP_READ, FALSE, path);
> +       if (!h)
> +               return -1;
> +       *mmap =3D MapViewOfFile(h, FILE_MAP_READ, 0, 0, 0);
> +       CloseHandle(h);
> +       if (!*mmap)
> +               return -1;
> +       if (length < 0) {
> +               MEMORY_BASIC_INFORMATION mbi;
> +               if (!VirtualQuery(*mmap, &mbi, sizeof(mbi))) {
> +                       UnmapViewOfFile(*mmap);
> +                       return -1;
> +               }
> +               if (mbi.RegionSize % page_size)
> +                       die("expected size %lu to be %lu aligned",
> +                                   mbi.RegionSize, page_size);
> +               last_page =3D (unsigned char *)*mmap + mbi.RegionSize=
 - page_size;
> +               length =3D *(unsigned long *)last_page;
> +       }
> +       return length;
> +}
> +
> +ssize_t git_shm_map(int oflag, int perm, ssize_t length, void **mmap=
,
> +                   int prot, int flags, const char *fmt, ...)
> +{
> +       SYSTEM_INFO si;
> +       va_list ap;
> +       char path[SHM_PATH_LEN];
> +
> +       GetSystemInfo(&si);
> +
> +       strcpy(path, "Local\\");
> +       va_start(ap, fmt);
> +       vsprintf(path + strlen(path), fmt, ap);
> +       va_end(ap);
> +
> +       if (oflag & O_CREAT)
> +               return create_shm_map(oflag, perm, length, mmap, prot=
,
> +                                     flags, path, si.dwPageSize);
> +       else
> +               return open_shm_map(oflag, perm, length, mmap, prot,
> +                                   flags, path, si.dwPageSize);
> +}
> +
> +void git_shm_unlink(const char *fmt, ...)
> +{
> +}
> +
>  #else
>
>  ssize_t git_shm_map(int oflag, int perm, ssize_t length, void **mmap=
,
> --
> 2.4.2.767.g62658d5-twtrsrc
>



--=20
Duy
