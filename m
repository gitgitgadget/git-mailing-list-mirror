From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 01/13] Use 'Git' in help messages
Date: Sat, 23 Feb 2013 15:41:05 -0800
Message-ID: <CAJDDKr5VG_c_RRK3Z++RNUev=3swmT0HUDocJE1h1QtSHYrYJA@mail.gmail.com>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
	<1361660761-1932-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:41:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Oip-00061k-Io
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 00:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987Ab3BWXlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 18:41:08 -0500
Received: from mail-ea0-f178.google.com ([209.85.215.178]:62874 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab3BWXlH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 18:41:07 -0500
Received: by mail-ea0-f178.google.com with SMTP id a14so770336eaa.9
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 15:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AriOAVSy4tVCMSM/8JR89ekuJi/ZG7/NE8+neCDS7TQ=;
        b=MzMwxs9mlu6iJYpEMlgV2+2LFtC9/2HUUJpejvgBZY2iFEmlhYxhrw79VyaTcDfpO/
         SNg2Ah9pNYz77WCicDcbLvK1U0r7QGrOSkhjA5QOonr3/tw+29TsqUMXP3nJlCt2NNuA
         WPF+aMWx/9Tv4WQB0wqG1eawaTBM9vnfEY1K+q76gTI4PVw0u1WB7OhIfLL9aYb+BXao
         gkY6vD5NAyx/hOlHyq8rhAWqUUcm841tERa6lr6XO4GUpu8MssOZuV82FPpD3q93a2Lv
         iJ9b/5PurWuJYSgFG5VYoWXBRQQkLR8EC9HNY7IT5WiIvvYpcVZ9RcBeG0lv9RSv6NhU
         Ylpg==
X-Received: by 10.14.3.133 with SMTP id 5mr22045184eeh.43.1361662865568; Sat,
 23 Feb 2013 15:41:05 -0800 (PST)
Received: by 10.14.194.3 with HTTP; Sat, 23 Feb 2013 15:41:05 -0800 (PST)
In-Reply-To: <1361660761-1932-2-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216936>

On Sat, Feb 23, 2013 at 3:05 PM, Philip Oakley <philipoakley@iee.org> wrote:
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  help.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/help.c b/help.c
> index 1dfa0b0..1c0e17d 100644
> --- a/help.c
> +++ b/help.c
> @@ -209,14 +209,14 @@ void list_commands(unsigned int colopts,
>  {
>         if (main_cmds->cnt) {
>                 const char *exec_path = git_exec_path();
> -               printf_ln(_("available git commands in '%s'"), exec_path);
> +               printf_ln(_("available Git commands in '%s'"), exec_path);
>                 putchar('\n');
>                 pretty_print_string_list(main_cmds, colopts);
>                 putchar('\n');
>         }
>
>         if (other_cmds->cnt) {
> -               printf_ln(_("git commands available from elsewhere on your $PATH"));
> +               printf_ln(_("Git commands available from elsewhere on your $PATH"));
>                 putchar('\n');
>                 pretty_print_string_list(other_cmds, colopts);
>                 putchar('\n');
> @@ -232,7 +232,7 @@ void list_common_cmds_help(void)
>                         longest = strlen(common_cmds[i].name);
>         }
>
> -       puts(_("The most commonly used git commands are:"));
> +       puts(_("The most commonly used Git commands are:"));
>         for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
>                 printf("   %s   ", common_cmds[i].name);
>                 mput_char(' ', longest - strlen(common_cmds[i].name));
> @@ -289,7 +289,7 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
>  #define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
>
>  static const char bad_interpreter_advice[] =
> -       N_("'%s' appears to be a git command, but we were not\n"
> +       N_("'%s' appears to be a Git command, but we were not\n"
>         "able to execute it. Maybe git-%s is broken?");
>
>  const char *help_unknown_cmd(const char *cmd)
> @@ -380,7 +380,7 @@ const char *help_unknown_cmd(const char *cmd)
>                 return assumed;
>         }
>
> -       fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
> +       fprintf_ln(stderr, _("git: '%s' is not a Git command. See 'git --help'."), cmd);
>
>         if (SIMILAR_ENOUGH(best_similarity)) {
>                 fprintf_ln(stderr,
> @@ -397,6 +397,6 @@ const char *help_unknown_cmd(const char *cmd)
>
>  int cmd_version(int argc, const char **argv, const char *prefix)
>  {
> -       printf("git version %s\n", git_version_string);
> +       printf("Git version %s\n", git_version_string);
>         return 0;
>  }

This is referring to "git the command", not "git the system",
so it should not be changed according to the rule that was
applied when many "git" strings were changed to "Git".

There are scripts, etc. in the wild that parse this output.
which is another reason we would not want to change this.

Does the build system use this output somewhere?

The other strings in this patch mention "git commands" which
the user is expected to type, so it might make sense to leave
them as-is as well.
-- 
David
