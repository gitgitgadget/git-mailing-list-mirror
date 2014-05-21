From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: [PATCH] Documentation: use "command-line" when used as a compound
 adjective, and fix other minor grammatical issues
Date: Wed, 21 May 2014 15:02:10 -0400
Message-ID: <CAEjxke8vhao6L4wq+yDQ816iBhO5TF2TVfzV_PNP-YMLdoCsGw@mail.gmail.com>
References: <1400698346-25949-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 21 21:02:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnBme-0002JZ-JG
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 21:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbaEUTCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 15:02:32 -0400
Received: from mailhub247.itcs.purdue.edu ([128.210.5.247]:58380 "EHLO
	mailhub247.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752939AbaEUTCc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2014 15:02:32 -0400
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com [209.85.192.42])
	(authenticated bits=0)
	by mailhub247.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id s4LJ2Uam005389
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 21 May 2014 15:02:30 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so4023920qgd.29
        for <git@vger.kernel.org>; Wed, 21 May 2014 12:02:30 -0700 (PDT)
X-Received: by 10.140.80.67 with SMTP id b61mr6582545qgd.98.1400698950362;
 Wed, 21 May 2014 12:02:30 -0700 (PDT)
Received: by 10.140.88.113 with HTTP; Wed, 21 May 2014 12:02:10 -0700 (PDT)
In-Reply-To: <1400698346-25949-1-git-send-email-jstjohn@purdue.edu>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-URL-Scanned: Yes
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249824>

On Wed, May 21, 2014 at 2:52 PM, Jason St. John <jstjohn@purdue.edu> wrote:
>
> Signed-off-by: Jason St. John <jstjohn@purdue.edu>
> ---
> Junio pointed out in the link below that there are a number of instances of e.g.
> "command line option" (without a hyphen) in the documentation. This patch fixes
> all of them that I was able to find. The other minor grammatical improvements were
> noticed while working on the switch to "command-line option"; they seemed too
> trivial to justify a separate patch.
>
> https://marc.info/?l=git&m=140054322310981&w=2
>
>  Documentation/config.txt                           | 10 +++++-----
>  Documentation/diff-config.txt                      |  2 +-
>  Documentation/git-bisect.txt                       |  2 +-
>  Documentation/git-config.txt                       |  2 +-
>  Documentation/git-daemon.txt                       |  6 +++---
>  Documentation/git-fast-import.txt                  | 10 +++++-----
>  Documentation/git-help.txt                         | 12 ++++++------
>  Documentation/git-ls-files.txt                     |  6 +++---
>  Documentation/git-read-tree.txt                    |  2 +-
>  Documentation/git-send-email.txt                   |  6 +++---
>  Documentation/git-svn.txt                          |  4 ++--
>  Documentation/git-web--browse.txt                  |  4 ++--
>  Documentation/git.txt                              |  8 ++++----
>  Documentation/gitcli.txt                           |  8 ++++----
>  Documentation/gitk.txt                             |  2 +-
>  Documentation/gitweb.conf.txt                      |  2 +-
>  Documentation/howto/setup-git-server-over-http.txt |  2 +-
>  Documentation/technical/http-protocol.txt          |  2 +-
>  Documentation/user-manual.txt                      |  8 ++++----
>  19 files changed, 49 insertions(+), 49 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1932e9b..553b300 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -381,7 +381,7 @@ false), while all other repositories are assumed to be bare (bare
>  core.worktree::
>         Set the path to the root of the working tree.
>         This can be overridden by the GIT_WORK_TREE environment
> -       variable and the '--work-tree' command line option.
> +       variable and the '--work-tree' command-line option.
>         The value can be an absolute path or relative to the path to
>         the .git directory, which is either specified by --git-dir
>         or GIT_DIR, or automatically discovered.
> @@ -523,7 +523,7 @@ core.askpass::
>         environment variable. If not set, fall back to the value of the
>         'SSH_ASKPASS' environment variable or, failing that, a simple password
>         prompt. The external program shall be given a suitable prompt as
> -       command line argument and write the password on its STDOUT.
> +       command-line argument and write the password on its STDOUT.
>
>  core.attributesfile::
>         In addition to '.gitattributes' (per-directory) and
> @@ -1324,7 +1324,7 @@ grep.extendedRegexp::
>  gpg.program::
>         Use this custom program instead of "gpg" found on $PATH when
>         making or verifying a PGP signature. The program must support the
> -       same command line interface as GPG, namely, to verify a detached
> +       same command-line interface as GPG, namely, to verify a detached
>         signature, "gpg --verify $file - <$signature" is run, and the
>         program is expected to signal a good signature by exiting with
>         code 0, and to generate an ascii-armored detached signature, the
> @@ -2295,7 +2295,7 @@ status.submodulesummary::
>         submodules when `diff.ignoreSubmodules` is set to 'all' or only
>         for those submodules where `submodule.<name>.ignore=all`. To
>         also view the summary for ignored submodules you can either use
> -       the --ignore-submodules=dirty command line option or the 'git
> +       the --ignore-submodules=dirty command-line option or the 'git
>         submodule summary' command, which shows a similar output but does
>         not honor these settings.
>
> @@ -2317,7 +2317,7 @@ submodule.<name>.branch::
>  submodule.<name>.fetchRecurseSubmodules::
>         This option can be used to control recursive fetching of this
>         submodule. It can be overridden by using the --[no-]recurse-submodules
> -       command line option to "git fetch" and "git pull".
> +       command-line option to "git fetch" and "git pull".
>         This setting will override that from in the linkgit:gitmodules[5]
>         file.
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index f07b451..b001779 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -76,7 +76,7 @@ diff.ignoreSubmodules::
>         this setting when reporting uncommitted changes. Setting it to
>         'all' disables the submodule summary normally shown by 'git commit'
>         and 'git status' when 'status.submodulesummary' is set unless it is
> -       overridden by using the --ignore-submodules command line option.
> +       overridden by using the --ignore-submodules command-line option.
>         The 'git submodule' commands are not affected by this setting.
>
>  diff.mnemonicprefix::
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index f986c5c..4cb52a7 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -117,7 +117,7 @@ $ git bisect visualize
>  `view` may also be used as a synonym for `visualize`.
>
>  If the 'DISPLAY' environment variable is not set, 'git log' is used
> -instead.  You can also give command line options such as `-p` and
> +instead.  You can also give command-line options such as `-p` and
>  `--stat`.
>
>  ------------
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index e9917b8..9dfa1a5 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -256,7 +256,7 @@ All writing options will per default write to the repository specific
>  configuration file. Note that this also affects options like '--replace-all'
>  and '--unset'. *'git config' will only ever change one file at a time*.
>
> -You can override these rules either by command line options or by environment
> +You can override these rules either by command-line options or by environment
>  variables. The '--global' and the '--system' options will limit the file used
>  to the global or system-wide file respectively. The GIT_CONFIG environment
>  variable has a similar effect, but you can specify any filename you want.
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index 223f731..a69b361 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -169,7 +169,7 @@ Git configuration files in that directory are readable by `<user>`.
>  --forbid-override=<service>::
>         Allow/forbid overriding the site-wide default with per
>         repository configuration.  By default, all the services
> -       are overridable.
> +       may be overridden.
>
>  --[no-]informative-errors::
>         When informative errors are turned on, git-daemon will report
> @@ -184,7 +184,7 @@ Git configuration files in that directory are readable by `<user>`.
>         Every time a client connects, first run an external command
>         specified by the <path> with service name (e.g. "upload-pack"),
>         path to the repository, hostname (%H), canonical hostname
> -       (%CH), ip address (%IP), and tcp port (%P) as its command line
> +       (%CH), IP address (%IP), and TCP port (%P) as its command-line
>         arguments. The external command can decide to decline the
>         service by exiting with a non-zero status (or to allow it by
>         exiting with a zero status).  It can also look at the $REMOTE_ADDR
> @@ -204,7 +204,7 @@ SERVICES
>  --------
>
>  These services can be globally enabled/disabled using the
> -command line options of this command.  If a finer-grained
> +command-line options of this command.  If finer-grained
>  control is desired (e.g. to allow 'git archive' to be run
>  against only in a few selected repositories the daemon serves),
>  the per-repository configuration file can be used to enable or
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index fd22a9a..3ffa2fa 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -231,7 +231,7 @@ Date Formats
>  ~~~~~~~~~~~~
>  The following date formats are supported.  A frontend should select
>  the format it will use for this import by passing the format name
> -in the \--date-format=<fmt> command line option.
> +in the \--date-format=<fmt> command-line option.
>
>  `raw`::
>         This is the Git native format and is `<time> SP <offutc>`.
> @@ -348,7 +348,7 @@ and control the current import process.  More detailed discussion
>  `done`::
>         Marks the end of the stream. This command is optional
>         unless the `done` feature was requested using the
> -       `--done` command line option or `feature done` command.
> +       `--done` command-line option or `feature done` command.
>
>  `cat-blob`::
>         Causes fast-import to print a blob in 'cat-file --batch'
> @@ -437,7 +437,7 @@ the email address from the other fields in the line.  Note that
>  of bytes, except `LT`, `GT` and `LF`.  `<name>` is typically UTF-8 encoded.
>
>  The time of the change is specified by `<when>` using the date format
> -that was selected by the \--date-format=<fmt> command line option.
> +that was selected by the \--date-format=<fmt> command-line option.
>  See ``Date Formats'' above for the set of supported formats, and
>  their syntax.
>
> @@ -1085,7 +1085,7 @@ Option commands must be the first commands on the input (not counting
>  feature commands), to give an option command after any non-option
>  command is an error.
>
> -The following commandline options change import semantics and may therefore
> +The following command-line options change import semantics and may therefore
>  not be passed as option:
>
>  * date-format
> @@ -1099,7 +1099,7 @@ not be passed as option:
>  If the `done` feature is not in use, treated as if EOF was read.
>  This can be used to tell fast-import to finish early.
>
> -If the `--done` command line option or `feature done` command is
> +If the `--done` command-line option or `feature done` command is
>  in use, the `done` command is mandatory and marks the end of the
>  stream.
>
> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index b21e9d7..3956525 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -80,9 +80,9 @@ CONFIGURATION VARIABLES
>  help.format
>  ~~~~~~~~~~~
>
> -If no command line option is passed, the 'help.format' configuration
> +If no command-line option is passed, the 'help.format' configuration
>  variable will be checked. The following values are supported for this
> -variable; they make 'git help' behave as their corresponding command
> +variable; they make 'git help' behave as their corresponding command-
>  line option:
>
>  * "man" corresponds to '-m|--man',
> @@ -93,15 +93,15 @@ help.browser, web.browser and browser.<tool>.path
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>  The 'help.browser', 'web.browser' and 'browser.<tool>.path' will also
> -be checked if the 'web' format is chosen (either by command line
> +be checked if the 'web' format is chosen (either by command-line
>  option or configuration variable). See '-w|--web' in the OPTIONS
>  section above and linkgit:git-web{litdd}browse[1].
>
>  man.viewer
>  ~~~~~~~~~~
>
> -The 'man.viewer' config variable will be checked if the 'man' format
> -is chosen. The following values are currently supported:
> +The 'man.viewer' configuration variable will be checked if the 'man'
> +format is chosen. The following values are currently supported:
>
>  * "man": use the 'man' program as usual,
>  * "woman": use 'emacsclient' to launch the "woman" mode in emacs
> @@ -124,7 +124,7 @@ For example, this configuration:
>                 viewer = woman
>  ------------------------------------------------
>
> -will try to use konqueror first. But this may fail (for example if
> +will try to use konqueror first. But this may fail (for example, if
>  DISPLAY is not set) and in that case emacs' woman mode will be tried.
>
>  If everything fails, or if no viewer is configured, the viewer specified
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index c0856a6..e26f01f 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -185,15 +185,15 @@ specifies the format of exclude patterns.
>
>  These exclude patterns come from these places, in order:
>
> -  1. The command line flag --exclude=<pattern> specifies a
> +  1. The command-line flag --exclude=<pattern> specifies a
>       single pattern.  Patterns are ordered in the same order
>       they appear in the command line.
>
> -  2. The command line flag --exclude-from=<file> specifies a
> +  2. The command-line flag --exclude-from=<file> specifies a
>       file containing a list of patterns.  Patterns are ordered
>       in the same order they appear in the file.
>
> -  3. The command line flag --exclude-per-directory=<name> specifies
> +  3. The command-line flag --exclude-per-directory=<name> specifies
>       a name of the file in each directory 'git ls-files'
>       examines, normally `.gitignore`.  Files in deeper
>       directories take precedence.  Patterns are ordered in the
> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
> index 056c0db..fa1d557 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -283,7 +283,7 @@ merge. The different stages represent the "result tree" (stage 0, aka
>  you are trying to merge (stage 2 and 3 respectively).
>
>  The order of stages 1, 2 and 3 (hence the order of three
> -<tree-ish> command line arguments) are significant when you
> +<tree-ish> command-line arguments) are significant when you
>  start a 3-way merge with an index file that is already
>  populated.  Here is an outline of how the algorithm works:
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index f0e57a5..d0fa18a 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -20,7 +20,7 @@ files in the directory), or directly as a revision list.  In the
>  last case, any format accepted by linkgit:git-format-patch[1] can
>  be passed to git send-email.
>
> -The header of the email is configurable by command line options.  If not
> +The header of the email is configurable via command-line options.  If not
>  specified on the command line, the user will be prompted with a ReadLine
>  enabled interface to provide the necessary information.
>
> @@ -68,7 +68,7 @@ The --cc option must be repeated for each user you want on the cc list.
>  When '--compose' is used, git send-email will use the From, Subject, and
>  In-Reply-To headers specified in the message. If the body of the message
>  (what you type after the headers and a blank line) only contains blank
> -(or Git: prefixed) lines the summary won't be sent, but From, Subject,
> +(or Git: prefixed) lines, the summary won't be sent, but From, Subject,
>  and In-Reply-To headers will be used unless they are removed.
>  +
>  Missing From or In-Reply-To headers will be prompted for.
> @@ -78,7 +78,7 @@ See the CONFIGURATION section for 'sendemail.multiedit'.
>  --from=<address>::
>         Specify the sender of the emails.  If not specified on the command line,
>         the value of the 'sendemail.from' configuration option is used.  If
> -       neither the command line option nor 'sendemail.from' are set, then the
> +       neither the command-line option nor 'sendemail.from' are set, then the
>         user will be prompted for the value.  The default for the prompt will be
>         the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
>         set, as returned by "git var -l".
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index fce5853..44c970c 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -148,8 +148,8 @@ the same local time zone.
>  [verse]
>  config key: svn-remote.<name>.ignore-paths
>  +
> -If the ignore-paths config key is set and the command line option is
> -also given, both regular expressions will be used.
> +If the ignore-paths configuration key is set, and the command-line
> +option is also given, both regular expressions will be used.
>  +
>  Examples:
>  +
> diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
> index 2de575f..16ede5b 100644
> --- a/Documentation/git-web--browse.txt
> +++ b/Documentation/git-web--browse.txt
> @@ -62,7 +62,7 @@ CONF.VAR (from -c option) and web.browser
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>  The web browser can be specified using a configuration variable passed
> -with the -c (or --config) command line option, or the 'web.browser'
> +with the -c (or --config) command-line option, or the 'web.browser'
>  configuration variable if the former is not used.
>
>  browser.<tool>.path
> @@ -87,7 +87,7 @@ the URLs passed as arguments.
>  Note about konqueror
>  --------------------
>
> -When 'konqueror' is specified by a command line option or a
> +When 'konqueror' is specified by a command-line option or a
>  configuration variable, we launch 'kfmclient' to try to open the HTML
>  man page on an already opened konqueror in a new tab if possible.
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index a041cd0..55764db 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -29,7 +29,7 @@ in-depth introduction.
>  After you mastered the basic concepts, you can come back to this
>  page to learn what commands Git offers.  You can learn more about
>  individual Git commands with "git help command".  linkgit:gitcli[7]
> -manual page gives you an overview of the command line command syntax.
> +manual page gives you an overview of the command-line command syntax.
>
>  Formatted and hyperlinked version of the latest Git documentation
>  can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
> @@ -39,7 +39,7 @@ ifdef::stalenotes[]
>  ============
>
>  You are reading the documentation for the latest (possibly
> -unreleased) version of Git, that is available from 'master'
> +unreleased) version of Git, that is available from the 'master'
>  branch of the `git.git` repository.
>  Documentation for older releases are available here:
>
> @@ -749,7 +749,7 @@ Git so take care if using Cogito etc.
>
>  'GIT_WORK_TREE'::
>         Set the path to the root of the working tree.
> -       This can also be controlled by the '--work-tree' command line
> +       This can also be controlled by the '--work-tree' command-line
>         option and the core.worktree configuration variable.
>
>  'GIT_NAMESPACE'::
> @@ -874,7 +874,7 @@ for further details.
>  'GIT_ASKPASS'::
>         If this environment variable is set, then Git commands which need to
>         acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
> -       will call this program with a suitable prompt as command line argument
> +       will call this program with a suitable prompt as command-line argument
>         and read the password from its STDOUT. See also the 'core.askpass'
>         option in linkgit:git-config[1].
>
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> index 1c3e109..dfe7d83 100644
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -3,7 +3,7 @@ gitcli(7)
>
>  NAME
>  ----
> -gitcli - Git command line interface and conventions
> +gitcli - Git command-line interface and conventions
>
>  SYNOPSIS
>  --------
> @@ -66,13 +66,13 @@ you will.
>  Here are the rules regarding the "flags" that you should follow when you are
>  scripting Git:
>
> - * it's preferred to use the non dashed form of Git commands, which means that
> + * it's preferred to use the non-dashed form of Git commands, which means that
>     you should prefer `git foo` to `git-foo`.
>
>   * splitting short options to separate words (prefer `git foo -a -b`
>     to `git foo -ab`, the latter may not even work).
>
> - * when a command line option takes an argument, use the 'stuck' form.  In
> + * when a command-line option takes an argument, use the 'stuck' form.  In
>     other words, write `git foo -oArg` instead of `git foo -o Arg` for short
>     options, and `git foo --long-opt=Arg` instead of `git foo --long-opt Arg`
>     for long options.  An option that takes optional option-argument must be
> @@ -103,7 +103,7 @@ Here is a list of the facilities provided by this option parser.
>  Magic Options
>  ~~~~~~~~~~~~~
>  Commands which have the enhanced option parser activated all understand a
> -couple of magic command line options:
> +couple of magic command-line options:
>
>  -h::
>         gives a pretty printed usage of the command.
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index 7e03fcc..7ae50aa 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -27,7 +27,7 @@ gitk-specific options.
>
>  gitk generally only understands options with arguments in the
>  'sticked' form (see linkgit:gitcli[7]) due to limitations in the
> -command line parser.
> +command-line parser.
>
>  rev-list options and arguments
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index 952f503..ebe7a6c 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -904,7 +904,7 @@ the following in your GITWEB_CONFIG file:
>         $feature{'snapshot'}{'override'} = 1;
>
>  If you allow overriding for the snapshot feature, you can specify which
> -snapshot formats are globally disabled. You can also add any command line
> +snapshot formats are globally disabled. You can also add any command-line
>  options you want (such as setting the compression level). For instance, you
>  can disable Zip compressed snapshots and set *gzip*(1) to run at level 6 by
>  adding the following lines to your gitweb configuration file:
> diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
> index 6de4f3c..f44e5e9 100644
> --- a/Documentation/howto/setup-git-server-over-http.txt
> +++ b/Documentation/howto/setup-git-server-over-http.txt
> @@ -181,7 +181,7 @@ On Debian:
>
>     Most tests should pass.
>
> -A command line tool to test WebDAV is cadaver. If you prefer GUIs, for
> +A command-line tool to test WebDAV is cadaver. If you prefer GUIs, for
>  example, konqueror can open WebDAV URLs as "webdav://..." or
>  "webdavs://...".
>
> diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
> index 20525d9..59be59b 100644
> --- a/Documentation/technical/http-protocol.txt
> +++ b/Documentation/technical/http-protocol.txt
> @@ -374,7 +374,7 @@ C: Send one `$GIT_URL/git-upload-pack` request:
>     C: 0000
>
>  The stream is organized into "commands", with each command
> -appearing by itself in a pkt-line.  Within a command line
> +appearing by itself in a pkt-line.  Within a command line,
>  the text leading up to the first space is the command name,
>  and the remainder of the line to the first LF is the value.
>  Command lines are terminated with an LF as the last byte of
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 022e74e..01200ed 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -173,13 +173,13 @@ index 65898fa..b002dc6 100644
>  --- a/init-db.c
>  +++ b/init-db.c
>  @@ -7,7 +7,7 @@
> -
> +
>   int main(int argc, char **argv)
>   {
>  -      char *sha1_dir = getenv(DB_ENVIRONMENT), *path;
>  +      char *sha1_dir, *path;
>         int len, i;
> -
> +
>         if (mkdir(".git", 0755) < 0) {
>  ------------------------------------------------
>

I just noticed some trailing whitespace got stripped out here by my
text editor, and I'm not sure if this will break formatting. Should I
resubmit this patch without the above hunk?

> @@ -4231,9 +4231,9 @@ Most of what `git rev-list` did is contained in `revision.c` and
>  controls how and what revisions are walked, and more.
>
>  The original job of `git rev-parse` is now taken by the function
> -`setup_revisions()`, which parses the revisions and the common command line
> +`setup_revisions()`, which parses the revisions and the common command-line
>  options for the revision walker. This information is stored in the struct
> -`rev_info` for later consumption. You can do your own command line option
> +`rev_info` for later consumption. You can do your own command-line option
>  parsing after calling `setup_revisions()`. After that, you have to call
>  `prepare_revision_walk()` for initialization, and then you can get the
>  commits one by one with the function `get_revision()`.
> --
> 1.9.3
>
