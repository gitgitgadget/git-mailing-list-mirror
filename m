From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSOC2014] changed logical chain in branch.c to lookup tables
Date: Tue, 11 Mar 2014 16:32:52 -0400
Message-ID: <CAPig+cSWw+3v8oCV2=kG_ASLPvg9J4S_FNg5UUFKXrFf2Lcb8w@mail.gmail.com>
References: <BLU0-SMTP15131ED34F192C9871ACC0CD5740@phx.gbl>
	<CAPig+cS3H_8gZOuyro_Vt0ay3xphvsB92zFgwFfCdgKsXjU0Gg@mail.gmail.com>
	<1394488063227-7605372.post@n2.nabble.com>
	<CAPig+cTOZrQY1azPCmzdrfut0S_-8ZDoob3cEqT7Z1kDpj+PQw@mail.gmail.com>
	<1394537604079-7605407.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Tamer TAS <tamertas@outlook.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 21:33:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNTMA-0005U4-R4
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 21:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbaCKUcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 16:32:53 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:34517 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862AbaCKUcx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 16:32:53 -0400
Received: by mail-yh0-f50.google.com with SMTP id c41so2997720yho.9
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dOL+SOzhvYowXYJYLy3xKvrF4j+TEgw1BnojdZ2k09o=;
        b=JJotXH9n1ZJF4m3dTIdVuTTrWREato6MzdVbuUPsegqwXs3eSEtLiS0iAnm+nwHE77
         hTmzE5icoi9I+LviZwZt4RyUMO5Q9WlQRvdWhUxap6Y2aQo/gBOJuJattP4as6FTcM+y
         0nzh+9sx9/4b7RJwf+KBVSH2GLWG84x/BNiqFpARv6chNzf9kAbHHC2XCDAy6Bcz550q
         jhK/GYvQkjEihSR1bcBMhASsc4m90ruA4CrR7QxiTcWzD/7UnSmrR1caW9mi9o4Do18o
         55uqzTFbgBDQ9iLxgT5cjNxSrP/slBwoKcLAsOtYf/3h+ksNMVUNZWYGK1nWIhU9JG3+
         aHLQ==
X-Received: by 10.236.137.8 with SMTP id x8mr24981943yhi.4.1394569972392; Tue,
 11 Mar 2014 13:32:52 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 11 Mar 2014 13:32:52 -0700 (PDT)
In-Reply-To: <1394537604079-7605407.post@n2.nabble.com>
X-Google-Sender-Auth: kZBDFP4ijEyoJEfsXSXiqX_XVqI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243894>

Thanks for the resubmission. Comments below.

On Tue, Mar 11, 2014 at 7:33 AM, Tamer TAS <tamertas@outlook.com> wrote:
> Subject: changed logical chain in branch.c to lookup tables

Use imperative tone: "change" rather than "changed"

Prefix the message with the part of the project you are touching. So,
for instance, you might write:

    Subject: install_branch_config: change logical chain to lookup table

> Eric Sunshine wrote
>> On Mon, Mar 10, 2014 at 5:47 PM, Tamer TAS &lt;
>
>> tamertas@
>
>> &gt; wrote:
>>
>> Section 4.3 of the GNU gettext manual [1] explains the issues in more
>> detail. I urge you to read it. The upshot is that translators fare
>> best when handed full sentences.
>>
>> Note also that your change effectively reverts d53a35032a67 [2], which
>> did away with the sort of string composition used in your patch.
>
> Eric thank you for your constructive feedbacks.
> I read the section 4.3 of GNU gettext manual and also checked the commit you
> mentioned.
> It seems like that my previous changes were not internationalization
> compatible.
> In order for a table-driven change to be compatible, the sentences has to be
> meaningful and not tokenized.
> I made the following change to the branch.c in order for the function to be
> both table-driven and
> internationalization compatible. Let me know if there are any oversights on
> my part.

This commentary is relevant to the ongoing email thread but not
suitable for the permanent commit message. Place it below the "---"
line just under your sign-off.

> Signed-off-by: TamerTas <tamertas@outlook.com>
> ---

It's considerate to reviewers to provide a link to the previous
attempt, like this [1]. This area below the "---" line is the
appropriate place to do so. Likewise, explain how this version differs
from the previous one.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243793

>  branch.c |   39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..4c04638 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -50,10 +50,25 @@ static int should_setup_rebase(const char *origin)
>  void install_branch_config(int flag, const char *local, const char *origin,
> const char *remote)

Your patch is whitespace damaged, probably due to being pasted into
your email. "git send-email" avoids such problems.

Indentation is also broken. Use tabs for indentation, and set tab
width to 8 in your editor, as explained in
Documentation/CodingGuidelines.

>  {
>         const char *shortname = remote + 11;
> +    const char *setup_messages[] = {
> +               _("Branch %s set up to track remote branch %s from %s."),
> +               _("Branch %s set up to track local branch %s."),
> +               _("Branch %s set up to track remote ref %s."),
> +               _("Branch %s set up to track local ref %s."),
> +               _("Branch %s set up to track remote branch %s from %s by rebasing."),
> +               _("Branch %s set up to track local branch %s by rebasing."),
> +               _("Branch %s set up to track remote ref %s by rebasing."),
> +               _("Branch %s set up to track local ref %s by rebasing.")
> +       };

On this project, arrays are usually (though not consistently) named in
singular form (for instance setup_message[]) so that a reference to a
single item, such as setup_message[42], reads more grammatically
correct.

It's not correct to use _() inside the initializer list. Instead use
N_(). Read section 4.7 of the GNU gettext manual [2] for an
explanation. You will still need to use _() at the point where you
extract the message from the array.

[2]: http://www.gnu.org/software/gettext/manual/gettext.html#Special-cases

>         int remote_is_branch = starts_with(remote, "refs/heads/");
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
>
> +    int msg_index = (!!origin           >> 0) +
> +                                       (!!remote_is_branch >> 1) +
> +                                       (!!rebasing         >> 2);

Are you sure this is correct? As I read it, msg_index will only ever
have a value of 0 or 1, which is unlikely what you intended.

>         if (remote_is_branch
>             && !strcmp(local, shortname)
>             && !origin) {
> @@ -77,29 +92,7 @@ void install_branch_config(int flag, const char *local,
> const char *origin, cons
>         strbuf_release(&key);
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote branch %s from %s by rebasing.")
> :
> -                                 _("Branch %s set up to track remote branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local ref %s."),
> -                                 local, remote);
> -               else
> -                       die("BUG: impossible combination of %d and %p",
> -                           remote_is_branch, origin);
> +               printf_ln(setup_messages[msg_index], local, remote);

This can't be correct.

In the original code, all of the printf_ln() invocations received
'local' as the first argument, but only two of them received 'remote',
yet you are passing 'remote' on every invocation.

Worse, the first and fifths items in your setup_messages[] table
expect three arguments (they have three %s's), but you're passing only
two, which will surely lead to a crash.

Also, wrap _() around setup_messages[msg_index], as noted above.

>         }
>  }
>
> --
> 1.7.9.5
