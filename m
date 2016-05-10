From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] mingw: introduce the 'core.hideDotFiles'
 setting
Date: Tue, 10 May 2016 13:58:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605101047510.4092@virtualbox>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de> <cover.1462603453.git.johannes.schindelin@gmx.de> <32f14c212946c7c1da8007c8eff536fe82872f5b.1462603453.git.johannes.schindelin@gmx.de>
 <xmqqeg9bw3gi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 13:58:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b06JI-00067B-Ow
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 13:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbcEJL6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 07:58:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:53594 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbcEJL63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 07:58:29 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LxPAo-1bgHnf2l5O-016zrg; Tue, 10 May 2016 13:58:10
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqeg9bw3gi.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:RMgHv1qzO6l579YhFaS+hgh86vYNbo/aC8lGHOxp1vgRsVPgTiS
 rLgoETzrMxVFOX1GQdwoW8PdvIgNjhYZMXKGAoXbkOBMp3/mSaDoA51wabxeAT6t261QD7H
 3IoDBUgDtNaDu64pPt94/TOEbIvEjsXU2T49VAaB4gUcL3P20t7N5NvguVUhPQ/cGZog+cA
 l2LPGBkVAuzGAayGToXqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4OK7xppa1Qw=:DOkQHlvRSTzpXCHFSTXtY1
 osOM5DVX2nsBIwRXlnyH+oVBpan9CQLOO62jKQSZAR9Ib4rGDtMDdlfI1dGeUVRcA4npRRx+O
 62RYEAhmWhodWtP7vjyIZoqRAR25bO0+5MuOtoQ4RHS1Cw1gaqHj1f/cTw5EL6XuuN7l55h31
 OykfXmE9phbriK0pihEao9J36oR87vepjISk6VcUC+PqsGV8JCh1Zb2t9oYIokItzlzHGUBmh
 OZDwcCvvAzZJEJC+3WUG0raFArLfky5xK9YA+RN9c0qBd8/jVF+q1nZd9SWkI8EEkCgYPqNjQ
 aXx/VnhpU8rH6S3xzTo0p7tV0Dd6LdlcZ1HJGtc23Trv7vzMNR+f0djblhckTgE2OCHKLs92E
 /0nZMAl89K0GVAjlY49Ms0w2q1D+uUdMosV3Rl0t4/qRLCjVQ0m0zSfIjnaoJtd+8yUos3Jut
 6t7EFGUZJaFD/mAC46W3+/PWqkNldIZsZgYgWMUYm0XF3mrPHjlk5efoixxUSR7nZ5zuEugY6
 VokOOKfMsKNffiP08PwDB8HRvV+B7dEVT7QzdlLnyQDN8adF7T9waU3us204nG4foXiou9/go
 gG8ejBlkMSbAwyolGDEEcxCSx2EVKmYxaq6XkUGktJjbISI9awoqdvo0UUifhKD3DCtDmdpKN
 YhMPbhEN2KV3Ej1fEaBg81qKD0JHRDVIxtquD7q6miTG2IbFldMquW2TFdHbTLRcRZvhy7bch
 Q6kw6VTjTSVdM6mb0crV6QskOen5nT6kC0ROZfDPdh0oINsncDqXesB8UK2SHjobg11xKQG5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294121>

Hi Junio,

On Mon, 9 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +core.hideDotFiles::
> > +	(Windows-only) If true, mark newly-created directories and files whose
> > +	name starts with a dot as hidden.  If 'dotGitOnly', only the `.git/`
> > +	directory is hidden, but no other files starting with a dot.  The
> > +	default mode is to mark only the `.git/` directory as hidden.
> 
> I think "The default mode is 'dotGitOnly'" is sufficient, given that
> it is described just one sentence before, which is still likely to
> be in readers' mind.  But I'll let it pass without tweaking.

Yeah, when rewriting this after Ramsay pointed out the erroneous
documentation, I wanted to fail on the crystal-clear side.

> > +enum hide_dotfiles_type {
> > +	HIDE_DOTFILES_FALSE = 0,
> > +	HIDE_DOTFILES_TRUE,
> > +	HIDE_DOTFILES_DOTGITONLY,
> 
> We allow ',' after the last array initializer, but not after the
> last enum definition.  I'll tweak it out while queuing.

Whoops. Sorry. I should have caught that five years ago.

> > @@ -319,6 +364,21 @@ int mingw_open (const char *filename, int oflags, ...)
> >  		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
> >  			errno = EISDIR;
> >  	}
> > +	if ((oflags & O_CREAT) && needs_hiding(filename)) {
> > +		/*
> > +		 * Internally, _wopen() uses the CreateFile() API which errors
> > +		 * out with an ERROR_ACCESS_DENIED if CREATE_ALWAYS was
> > +		 * specified and an already existing file's attributes do not
> > +		 * match *exactly*. As there is no mode or flag we can set that
> > +		 * would correspond to FILE_ATTRIBUTE_HIDDEN, let's just try
> > +		 * again *without* the O_CREAT flag (that corresponds to the
> > +		 * CREATE_ALWAYS flag of CreateFile()).
> > +		 */
> > +		if (fd < 0 && errno == EACCES)
> > +			fd = _wopen(wfilename, oflags & ~O_CREAT, mode);
> 
> This "retry if we got EACCESS" felt strange to me in two ways.  One
> is explained well in the comment and you know what you are doing, as
> opposed to me who is clueless with CreateFile() API.
> 
> The other is why you do not have to retry creation in a similar way
> when !needs_hiding(filename).  I didn't see anything in the function
> before reaching this point that does anything differently based on
> needs_hiding().  Can't the same 'ERROR_ACCESS_DENIED' error trigger
> if CREATE_ALWAYS was specified and file attributes of an existing
> file match, and if it can, don't you want to retry that too, even if
> you are not going to hide the filename?

The attributes that can trigger the ERROR_ACCESS_DENIED error are the
hidden flag and the system flag. Since Git *never* marks any file as
system file, we should be safe. Granted, it would be theoretically
possible that some enterprisey person tracks system files and marks them
via some hook or some such. I am not willing to introduce support for that
until somebody *actually* needs it and puts in the work to verify that it
will work as expected.

There is another case where ERROR_ACCESS_DENIED can be returned that is
worth mentioning: under certain circumstances, deleting a file does not
delete the file right away, but waits until the last handle to said file
was closed. In such a case, the user cannot create that file, either. It
does not exactly hurt to try without O_CREAT again, but it does not make
sense in this case, either.

And finally, there are programs that lock files when they access them (MS
Access, I am looking at you). I believe that we would end up with an
EACCES in that case, too, but we would not really be able to do much about
it.

We *could* introduce the same "Try again?" handling as we already have for
rename() and friends, but I'd rather get Karsten's clean-up patch
https://github.com/git-for-windows/git/commit/86e8394c2 in before doing
that. If we do it for fopen()/freopen()/open() at all.

> > +		if (fd >= 0 && set_hidden_flag(wfilename, 1))
> > +			warning("Could not mark '%s' as hidden.", filename);
> > +	}
> 
> I'll tweak all new instances of "Could" with s/Could/could/ to save
> Micheal trouble (cf. b846ae21daf).

You mean Michael? ;-)

Anyway, the next iteration of this patch is on its way.

Ciao,
Dscho
