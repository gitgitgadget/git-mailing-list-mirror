From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 01/13] Use 'Git' in help messages
Date: Sat, 23 Feb 2013 23:54:08 +0000
Message-ID: <512956A0.2000201@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org> <1361660761-1932-2-git-send-email-philipoakley@iee.org> <CAJDDKr5VG_c_RRK3Z++RNUev=3swmT0HUDocJE1h1QtSHYrYJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:54:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9OvM-0004So-TY
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 00:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759257Ab3BWXyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 18:54:12 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:34945 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758152Ab3BWXyM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 18:54:12 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApQBAJJTKVFZ8rke/2dsb2JhbAANOIZPuwKBHYMSAQEBAQIBIwQRQAEFCwsOCgICBRYLAgIJAwIBAgFFBg0BBQIBAYgJrCtxkViBI404MweCLYETA6op
X-IronPort-AV: E=Sophos;i="4.84,724,1355097600"; 
   d="scan'208";a="419581855"
Received: from host-89-242-185-30.as13285.net (HELO [192.168.0.7]) ([89.242.185.30])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 23 Feb 2013 23:54:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <CAJDDKr5VG_c_RRK3Z++RNUev=3swmT0HUDocJE1h1QtSHYrYJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216937>

On 23/02/13 23:41, David Aguilar wrote:
> On Sat, Feb 23, 2013 at 3:05 PM, Philip Oakley <philipoakley@iee.org> wrote:
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>   help.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/help.c b/help.c
>> index 1dfa0b0..1c0e17d 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -209,14 +209,14 @@ void list_commands(unsigned int colopts,
>>   {
>>          if (main_cmds->cnt) {
>>                  const char *exec_path = git_exec_path();
>> -               printf_ln(_("available git commands in '%s'"), exec_path);
>> +               printf_ln(_("available Git commands in '%s'"), exec_path);
>>                  putchar('\n');
>>                  pretty_print_string_list(main_cmds, colopts);
>>                  putchar('\n');
>>          }
>>
>>          if (other_cmds->cnt) {
>> -               printf_ln(_("git commands available from elsewhere on your $PATH"));
>> +               printf_ln(_("Git commands available from elsewhere on your $PATH"));
>>                  putchar('\n');
>>                  pretty_print_string_list(other_cmds, colopts);
>>                  putchar('\n');
>> @@ -232,7 +232,7 @@ void list_common_cmds_help(void)
>>                          longest = strlen(common_cmds[i].name);
>>          }
>>
>> -       puts(_("The most commonly used git commands are:"));
>> +       puts(_("The most commonly used Git commands are:"));
>>          for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
>>                  printf("   %s   ", common_cmds[i].name);
>>                  mput_char(' ', longest - strlen(common_cmds[i].name));
>> @@ -289,7 +289,7 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
>>   #define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
>>
>>   static const char bad_interpreter_advice[] =
>> -       N_("'%s' appears to be a git command, but we were not\n"
>> +       N_("'%s' appears to be a Git command, but we were not\n"
>>          "able to execute it. Maybe git-%s is broken?");
>>
>>   const char *help_unknown_cmd(const char *cmd)
>> @@ -380,7 +380,7 @@ const char *help_unknown_cmd(const char *cmd)
>>                  return assumed;
>>          }
>>
>> -       fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
>> +       fprintf_ln(stderr, _("git: '%s' is not a Git command. See 'git --help'."), cmd);
>>
>>          if (SIMILAR_ENOUGH(best_similarity)) {
>>                  fprintf_ln(stderr,
>> @@ -397,6 +397,6 @@ const char *help_unknown_cmd(const char *cmd)
>>
>>   int cmd_version(int argc, const char **argv, const char *prefix)
>>   {
>> -       printf("git version %s\n", git_version_string);
>> +       printf("Git version %s\n", git_version_string);
>>          return 0;
>>   }
>
> This is referring to "git the command", not "git the system",
> so it should not be changed according to the rule that was
> applied when many "git" strings were changed to "Git".

I'd felt that they were referring to 'Git the system', hence the changes.
>
> There are scripts, etc. in the wild that parse this output.

My first pass avoided the 'git --version' response on the basis
that it might be used in the tests or elsewhere, but I didn't
find an occurrence of it's use (in Git), so I thought 'why not'.
However I'm not wedded to it. If the exact phrase 'git version'
is parsed in the wild it then we should let it be.

> which is another reason we would not want to change this.
>
> Does the build system use this output somewhere?
>
> The other strings in this patch mention "git commands" which
> the user is expected to type, so it might make sense to leave
> them as-is as well.
>
