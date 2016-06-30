Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_50,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9884C1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 13:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbcF3N66 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 09:58:58 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:48444 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932067AbcF3N4T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2016 09:56:19 -0400
X-AuditID: 1207440c-94bff700000069e9-9b-5775247c3fec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DA.E4.27113.C7425775; Thu, 30 Jun 2016 09:54:04 -0400 (EDT)
Received: from [192.168.69.130] (p548D60CA.dip0.t-ipconnect.de [84.141.96.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5UDs0Tb031316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 30 Jun 2016 09:54:01 -0400
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring
 blank lines
To:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
References: <20160616174620.1011-1-sbeller@google.com>
 <20160617153637.GA9314@sigill.intra.peff.net>
 <CAGZ79kZgdbqnWW9uqeBHNDbyGVfc0x5gTJbyD0Nyi1i3SNvENQ@mail.gmail.com>
 <576C1803.5050905@alum.mit.edu>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <57752478.1000302@alum.mit.edu>
Date:	Thu, 30 Jun 2016 15:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <576C1803.5050905@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsUixO6iqFurUhpu8GU+o0XXlW4mi4beK8wW
	uxf3M1v83TOPzeJHSw+zxcf379kszl3oZbbYvLmdxYHDY+Gs5yweO2fdZfdYsKnU41nvHkaP
	i5eUPT5vkgtgi+K2SUosKQvOTM/Tt0vgzth5qZetoPEMY0X3qdusDYwvGxi7GDk5JARMJG69
	fs/UxcjFISSwlVGiY+cbKOc8k8TJ5Q/YQaqEBSIkrhx9BNYhIuAo8eLZQnaoIkaJPUd+MIM4
	zAI9jBJrd35kA6liE9CVWNTTzARi8wpoS6xYvREozsHBIqAq8XYCD0hYVCBE4vy6rawQJYIS
	J2c+YQGxOQV0JHY8fAEWZxZQl/gz7xIzhC0v0bx1NvMERv5ZSFpmISmbhaRsASPzKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQwOfZwfhtncwhRgEORiUe3hmsJeFCrIll
	xZW5hxglOZiURHkXPgYK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuF9JV8aLsSbklhZlVqUD5OS
	5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQkuDtUwZqFCxKTU+tSMvMKUFIM3FwggznkhIp
	Ts1LSS1KLC3JiAdFZnwxMDZBUjxAe5NA2nmLCxJzgaIQracYdTnu7HqwlkmIJS8/L1VKnHeT
	ElCRAEhRRmke3ApYmnvFKA70sTBvNsgoHmCKhJv0CmgJE9AS5tJikCUliQgpqQZG/5yzk+39
	NBOl7u87/uG9afHbc0ltZ2I35esujD7wS+nNLuENzqvStG+f9v21vk9ffJb7im1bd2iw/XE/
	ft7lbse9S5Yr5lQdag5/M3vGebOfm+dUHZPOvZHnLcVqXhv7OVta5Ouxj8waiz/W/D6wt//s
	U/6nndeyOV/55RyJ6l2b//qZ+OuSWUosxRmJhlrMRcWJADcs4wlOAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/23/2016 07:10 PM, Michael Haggerty wrote:
> On 06/17/2016 06:09 PM, Stefan Beller wrote:
>> I think before spending more time on discussing and implementing new
>> (hopefully better) heuristics, I'd want to step back and try to be a bit more
>> systematic, i.e. I'll want to collect lots of test cases in different languages
>> and use cases. A mini test suite, maybe?
> 
> Stefan,
> 
> I've also been playing around with diff heuristics and also trying to
> find some good test data. Have you put together some test cases yet?

I put quite of work into tooling to evaluate diff heuristics, and just
published it on GitHub:

    https://github.com/mhagger/diff-slider-tools

The README there is hopefully enough to let people get started using it
to test their own favorite heuristics.

!!!
Please be careful! The scripts are not hardened against strangely-named
files!
!!!

I've run a bunch of tests of the heuristic that I described in the
previous email against a bunch of repositories (to try to get a sampling
of popular languages): ant, bugzilla, couchdb, docker, git, ipython,
junit, nodejs, phpmyadmin, test-more, test-unit, xmonad.

I haven't done a lot of systematic analysis yet, nor tried to optimize
the heuristic systematically, but by eye the results look very good.
Some constructs (C preprocessor directives, Shell here documents)
sometimes confuse it because of their weird indentation, and of course
code with inconsistent indentation or strangely-placed blank lines
doesn't get the best results. But in a large majority of cases where it
disagrees with the standard Git or with `git --compaction-heuristic`, it
does a better job.

Below are a few examples to show off some typical results. I promise I
tried not to cherry pick only flattering examples.

In the output below, `|` mark the highest and lowest possible
positioning of the "slider" (a group of added or deleted lines whose
exact identity is ambiguous). Current Git, by default, always chooses
the lowest positioning. "c" is where Git master with
`--compaction-heuristic` chooses to position the slider, and `i` is the
choice of my indentation-based algorithm. The numbers are just the shift
relative to the standard shift.

Michael

The algorithm does pretty well with XML and HTML:

> fef3ea39f8bd474add292bb6437df6cbd22e1ba7:contributors.xml a394a0bdf8e6240dc09023a8260059c57c158a00:contributors.xml + 1624
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >    <last>Toni</last>
>                >  </name>
>                >  <name>
>                >    <first>Vincent</first>
>                >    <last>Legoll</last>
>       -2 |     >  </name>
>       -1 |   i >  <name>
>        0 || ci >    <first>Vincent</first>
>          || ci >    <last>Privat</last>
>           | ci >  </name>
>           | c  >  <name>
>                >    <first>Vimil</first>
>                >    <last>Saju</last>
>                >  </name>
>                >  <name>
>                >    <first>Vitold</first>
>                >    <last>Sedyshev</last>
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> 789422e131b6c2c003d94f394169a64297e986c6:manual/Tasks/signjar.html 7f51882300a8e40ff675867e055061867ba6c8bd:manual/Tasks/signjar.html + 151
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >  </tr>
>                >  <tr>
>                >    <td valign="top">tsacert</td>
>                >    <td valign="top">alias in the keystore for a timestamp authority for
>                >    timestamped JAR files in Java1.5+</td>
>       -3 |     >    <td valign="top" align="center">No</td>
>       -2 |     >  </tr>
>       -1 |   i >  <tr>
>        0 || ci >    <td valign="top">tsaproxyhost</td>
>          || ci >    <td valign="top">proxy host to be used when connecting to TSA server</td>
>          || ci >    <td valign="top" align="center">No</td>
>          || ci >  </tr>
>          || ci >  <tr>
>          || ci >    <td valign="top">getTsaproxyport</td>
>          || ci >    <td valign="top">proxy port to be used when connecting to TSA server</td>
>           | ci >    <td valign="top" align="center">No</td>
>           | ci >  </tr>
>           | c  >  <tr>
>                >    <td valign="top">executable</td>
>                >    <td valign="top">Specify a particular <code>jarsigner</code> executable
>                >      to use in place of the default binary (found in the same JDK as
>                >      Apache Ant is running in).<br/>
>                >      Must support the same command line options as the Sun JDK
>                >      jarsigner command.
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Java:

> de5b4058b9bb039cdb17082fc543098de598ece2:src/main/org/apache/tools/ant/taskdefs/optional/ssh/AbstractSshMessage.java 3fe363e2120342f6de2b219c3bd74efe9aea2803:src/main/org/apache/tools/ant/taskdefs/optional/ssh/AbstractSshMessage.java + 208
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >     * @return true if the verbose attribute is set
>                >     * @since Ant 1.6.2
>                >     */
>                >    protected final boolean getVerbose() {
>                >        return verbose;
>       -3 |     >    }
>       -2 |     >
>       -1 |  ci >    /**
>        0 || ci >     * Is the compressed attribute set.
>          || ci >     * @return true if the compressed attribute is set
>          || ci >     * @since Ant 1.9.8
>          || ci >     */
>          || ci >    protected final boolean getCompressed() {
>          || ci >        return compressed;
>           | ci >    }
>           | ci >
>           |    >    /**
>                >     * Track progress every 10% if 100kb < filesize < 1mb. For larger
>                >     * files track progress for every percent transmitted.
>                >     * @param filesize the size of the file been transmitted
>                >     * @param totalLength the total transmission size
>                >     * @param percentTransmitted the current percent transmitted
>                >     * @return the percent that the file is of the total
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> cd1ff3566ed915392041314eb583a638bcb1eb64:src/main/org/apache/tools/ant/taskdefs/optional/ejb/WeblogicDeploymentTool.java a8d6367ddc214b4956b2a7d6b779930df5e43515:src/main/org/apache/tools/ant/taskdefs/optional/ejb/WeblogicDeploymentTool.java - 888
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >                    // empty
>                >                }
>                >            }
>                >
>                >            if (newJarStream != null) {
>       -1 |   i >                try {
>        0 || ci >                    newJarStream.close();
>          || ci >                } catch (IOException closeException) {
>          || ci >                    // empty
>          || ci >                }
>          || ci >
>           | c  >                try {
>                >                    FILE_UTILS.rename(newWLJarFile, weblogicJarFile);
>                >                } catch (IOException renameException) {
>                >                    log(renameException.getMessage(), Project.MSG_WARN);
>                >                    rebuild = true;
>                >                }
>                >            }
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Perl:

> bb18f8a6d560fa141f812dddcf6f6d8fe8b49dbb:Bugzilla/DB.pm 16f1833e572297edd89faddb69364e09efecdfdb:Bugzilla/DB.pm + 98
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                ># PostgreSQL, and hopefully will get us as much Unicode support as possible,
>                ># depending on how well the regexp engines of the various databases support
>                ># Unicode.
>                >use constant WORD_START => '(^|[^[:alnum:]])';
>                >use constant WORD_END   => '($|[^[:alnum:]])';
>       -2 |     >
>       -1 |  ci >#####################################################################
>        0 || ci ># Overridden Superclass Methods 
>          || ci >#####################################################################
>          || ci >
>          || ci >sub quote {
>          || ci >    my $self = shift;
>          || ci >    my $retval = $self->SUPER::quote(@_);
>          || ci >    trick_taint($retval) if defined $retval;
>          || ci >    return $retval;
>          || ci >}
>           | ci >
>           |    >#####################################################################
>                ># Connection Methods
>                >#####################################################################
>                >
>                >sub connect_shadow {
>                >    my $params = Bugzilla->params;
>                >    die "Tried to connect to non-existent shadowdb" 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> dbfd6207290d1eee53fddec4c7c3b4aac0b2d47a:Bugzilla/Install/Requirements.pm 3c7ab8316f97fe84222ccacf0d1b4be9cd43e9f8:Bugzilla/Install/Requirements.pm - 338
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >        feature => ['rest']
>                >    },
>                >    {
>                >        package => 'HTTP-Response',
>                >        module  => 'HTTP::Response',
>       -4 |     >        version => 0,
>       -3 |     >        feature => ['rest']
>       -2 |     >    },
>       -1 |   i >    {
>        0 || ci >        package => 'URI-Escape',
>          || ci >        module  => 'URI::Escape',
>           | ci >        version => 0,
>           | ci >        feature => ['rest']
>           | ci >    },
>           | c  >    {
>                >        # We need the 'utf8_mode' method of HTML::Parser, for HTML::Scrubber.
>                >        package => 'HTML-Parser',
>                >        module  => 'HTML::Parser',
>                >        version => ($^V >= v5.13.3) ? '3.67' : '3.40',
>                >        feature => ['html_desc'],
>                >    },
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Erlang:

> 56f969b3c49375c5321eb3cceb0fe346f8535c22:src/couchdb/couch_httpd.erl b90e40212663474e873fde6cab343c31c1e635e7:src/couchdb/couch_httpd.erl + 332
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >        case couch_httpd_cors:is_preflight_request(HttpReq) of
>                >        #httpd{} ->
>                >        case authenticate_request(HttpReq, AuthHandlers) of
>                >        #httpd{} = Req ->
>                >            HandlerFun(Req);
>       -2 |   i >        Response ->
>       -1 |   i >            Response
>        0 || ci >            end;
>           | c  >        Response ->
>           | c  >            Response
>                >        end
>                >    catch
>                >        throw:{http_head_abort, Resp0} ->
>                >            {ok, Resp0};
>                >        throw:{invalid_json, S} ->
>                >            ?LOG_ERROR("attempted upload of invalid JSON (set log_level to debug to log it)", []),
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Go:

> 7b2b4eb40cfd907f3aa20b630cc2feeb8460404a:opts/hosts.go fb3eb1c27ef5520571c599ead8a72b343748db39:opts/hosts.go + 132
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >	u, err := url.Parse("tcp://" + addr)
>                >	if err != nil {
>                >		return "", err
>                >	}
>                >	host, port, err := net.SplitHostPort(u.Host)
>       -1 |   i >	if err != nil {
>        0 || ci >		// try port addition once
>          || ci >		host, port, err = net.SplitHostPort(net.JoinHostPort(u.Host, defaultPort))
>          || ci >	}
>           | c  >	if err != nil {
>                >		return "", fmt.Errorf("Invalid bind address format: %s", tryAddr)
>                >	}
>                >
>                >	if host == "" {
>                >		host = defaultHost
>                >	}
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

gettext source:

> aef18cc6063106075afeb3a78ec72656b19c8bde:po/de.po b0e098ce46ce7f8ecd975720ccec8d0eb7787e50:po/de.po - 12954
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >#~ msgid "unmerged:   %s"
>                >#~ msgstr "nicht zusammengeführt:   %s"
>                >
>                >#~ msgid "input paths are terminated by a null character"
>                >#~ msgstr "Eingabepfade sind durch ein NUL Zeichen abgeschlossen"
>       -2 |     >
>       -1 |  ci >#~ msgid ""
>        0 || ci >#~ "The following untracked files would NOT be saved but need to be removed "
>          || ci >#~ "by stash save:"
>          || ci >#~ msgstr ""
>          || ci >#~ "Die folgenden unbeobachteten Dateien würden NICHT gespeichert werden,\n"
>          || ci >#~ "müssen aber durch \"stash save\" entfernt werden:"
>           | ci >
>           |    >#~ msgid ""
>                >#~ "Aborting. Consider using either the --force or --include-untracked option."
>                >#~ msgstr ""
>                >#~ "Abgebrochen. Benutzen Sie entweder die Option --force oder --include-"
>                >#~ "untracked."
>                >
>                >#~ msgid "  (fix conflicts and then run \"git am --resolved\")"
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

C:

> eeff891ac756fd97a05476446f15269b714ce4cc:grep.c 79a77109d3d0d364910ff7fa8c605c554dc4c3e0:grep.c + 1133
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >		regmatch_t match;
>                >		enum grep_context ctx = GREP_CONTEXT_BODY;
>                >		int ch = *eol;
>                >		int eflags = 0;
>                >
>       -1 |   i >		if (sign == ':')
>        0 || ci >			match_color = opt->color_match_selected;
>          || ci >		else
>          || ci >			match_color = opt->color_match_context;
>           | c  >		if (sign == ':')
>                >			line_color = opt->color_selected;
>                >		else if (sign == '-')
>                >			line_color = opt->color_context;
>                >		else if (sign == '=')
>                >			line_color = opt->color_function;
>                >		*eol = '\0';
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Tcl:

> a9ae14a1c50a9b5bd051be629dba0fb04b6fd67a:git-gui.sh 25476c63e7d3357f955b44dd6a7c825aba819987:git-gui.sh - 3158
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >
>                ># -- Diff Body Context Menu
>                >#
>                >
>                >proc create_common_diff_popup {ctxm} {
>       -1 |   i >	$ctxm add command \
>        0 || ci >		-label [mc "Show Less Context"] \
>          || ci >		-command show_less_context
>          || ci >	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
>          || ci >	$ctxm add command \
>          || ci >		-label [mc "Show More Context"] \
>          || ci >		-command show_more_context
>          || ci >	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
>          || ci >	$ctxm add separator
>           | c  >	$ctxm add command \
>                >		-label [mc Refresh] \
>                >		-command reshow_diff
>                >	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
>                >	$ctxm add command \
>                >		-label [mc Copy] \
>                >		-command {tk_textCopy $ui_diff}
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Shell:

> 34a82bda7766f000ef646130ed3f6af58ca23aa2:git-subtree.sh 942dce5578c8eb03fdc7f9109c8418d499e931ff:git-subtree.sh + 40
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >rejoin=
>                >ignore_joins=
>                >annotate=
>                >
>                >debug()
>       -1 |   i >{
>        0 || ci >	if [ -n "$debug" ]; then
>          || ci >		echo "$@" >&2
>          || ci >	fi
>          || ci >}
>          || ci >
>          || ci >say()
>           | c  >{
>                >	if [ -z "$quiet" ]; then
>                >		echo "$@" >&2
>                >	fi
>                >}
>                >
>                >assert()
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Python:

> 9ccc64b8ea94a9083038b079a8e2691ae94591fe:IPython/html/base/handlers.py db6ce120fc0bc0a4b29969f43af98e4841d5e1be:IPython/html/base/handlers.py - 90
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >    def cookie_name(self):
>                >        default_cookie_name = non_alphanum.sub('-', 'username-{}'.format(
>                >            self.request.host
>                >        ))
>                >        return self.settings.get('cookie_name', default_cookie_name)
>       -2 |     >    
>       -1 |   i >    @property
>        0 || ci >    def password(self):
>          || ci >        """our password"""
>          || ci >        return self.settings.get('password', '')
>           | ci >    
>           | c  >    @property
>                >    def logged_in(self):
>                >        """Is a user currently logged in?
>                >
>                >        """
>                >        user = self.get_current_user()
>                >        return (user and not user == 'anonymous')
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

javascript (and JSON):

> d3c3a928c3a2f9e961881b47ef0796e57ae8d429:tools/eslint/lib/rules/no-arrow-condition.js d7aa8fa088f3b8a31c7d85c6d71824c8c60e7c17:tools/eslint/lib/rules/no-confusing-arrow.js - 58
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >//------------------------------------------------------------------------------
>                >// Rule Definition
>                >//------------------------------------------------------------------------------
>                >
>                >module.exports = function(context) {
>       -1 |   i >    /**
>        0 || ci >     * Reports if a conditional statement is an arrow function.
>          || ci >     * @param {ASTNode} node - A node to check and report.
>          || ci >     * @returns {void}
>          || ci >     */
>          || ci >    function checkCondition(node) {
>          || ci >        if (isArrowFunction(node)) {
>          || ci >            context.report(node, "Arrow function `=>` used inside {{statementType}} instead of comparison operator.", {statementType: node.type});
>          || ci >        }
>          || ci >    }
>          || ci >
>           | c  >    /**
>                >     * Reports if an arrow function contains an ambiguous conditional.
>                >     * @param {ASTNode} node - A node to check and report.
>                >     * @returns {void}
>                >     */
>                >    function checkArrowFunc(node) {
>                >        if (isConditional(node)) {
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

PHP:

> cc9550579c02d652686bdc574bc91fb982f7d95b:libraries/ThemeManager.php ca5eb903b04035f78819ae1e14ff888155bd3e32:libraries/ThemeManager.php + 20
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                > *
>                > * @package PhpMyAdmin
>                > */
>                >class ThemeManager
>                >{
>       -1 |   i >    /**
>        0 || ci >     * ThemeManager instance
>          || ci >     *
>          || ci >     * @access private
>          || ci >     * @static
>          || ci >     * @var ThemeManager
>          || ci >     */
>          || ci >    private static $_instance;
>          || ci >
>           | c  >    /**
>                >     * @var string path to theme folder
>                >     * @access protected
>                >     */
>                >    private $_themes_path = './themes/';
>                >
>                >    /**
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ruby:

> 0ae3800be7ca632c47c089d527b53a8f66960c60:test/test_assertions.rb c35d9e2de60441cae592a300dae1460b45562cce:test/test_assertions.rb - 120
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >      end
>                >      
>                >      def test_assert_equal
>                >        check_nothing_fails {
>                >          assert_equal("string1", "string1")
>       -2 |     >        }
>       -1 |   i >        check_nothing_fails {
>        0 || ci >          assert_equal( "string1", "string1", "successful assert_equal")
>           | ci >        }
>           | c  >        check_nothing_fails {
>                >          assert_equal("string1", "string1", "successful assert_equal")
>                >        }
>                >
>                >        message = <<-EOM.chomp
>                ><"string1"> expected but was
>                ><"string2">.
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


It often fails to get C preprocessor directives right:

> a08595f76159b09d57553e37a5123f1091bb13e7:http.c aeff8a61216bf6e0d663c08c583bc8552fa3c344:http.c + 429
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
>                >#endif
>                >#if LIBCURL_VERSION_NUM >= 0x070908
>                >	if (ssl_capath != NULL)
>                >		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
>       -1 |   i >#endif
>        0 || ci >#if LIBCURL_VERSION_NUM >= 0x072c00
>          || ci >	if (ssl_pinnedkey != NULL)
>          || ci >		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
>           | c  >#endif
>                >	if (ssl_cainfo != NULL)
>                >		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
>                >
>                >	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
>                >		curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
>                >				 curl_low_speed_limit);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

And it gets confused by unusual blank line placement:

> ed55169834a3ce16a271def9630c858626ded34d:tools/eslint/node_modules/doctrine/lib/doctrine.js 2d441493a4a46a511ba1bdf93e442c3288fbe92d:tools/eslint/node_modules/doctrine/lib/doctrine.js + 330
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >                        name === 'external' ||
>                >                        name === 'event')) {
>                >                    name += advance();
>                >                    name += scanIdentifier(last);
>                >
>       -1 |   i >                }
>        0 || ci >                if(source.charCodeAt(index) === 0x5B  /* '[' */ && source.charCodeAt(index + 1) === 0x5D  /* ']' */){
>          || ci >                    name += advance();
>          || ci >                    name += advance();
>           | c  >                }
>                >                while (source.charCodeAt(index) === 0x2E  /* '.' */ ||
>                >                        source.charCodeAt(index) === 0x23  /* '#' */ ||
>                >                        source.charCodeAt(index) === 0x7E  /* '~' */) {
>                >                    name += advance();
>                >                    name += scanIdentifier(last);
>                >                }
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

or inconsistent indentation:

> 1768d08d029dc3bf1ab88e26df0a9b40ae61227f:src/main/java/org/junit/internal/runners/statements/FailOnTimeout.java 5ca9da987a7d4dc00e082aaf552cbd8ee8c7bd33:src/main/java/org/junit/internal/runners/statements/FailOnTimeout.java + 136
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                >                    maxCpuTime = threadCpuTime;
>                >                }
>                >    		}   			
>                >    	}
>                >    	return (stuckThread == mainThread) ? null : stuckThread;
>       -2 |   i >    }
>       -1 |   i >
>        0 || ci >    /**
>          || ci >     * Returns the CPU time used by a thread, if possible.
>          || ci >     * @param thr The thread to query.
>          || ci >     * @return The CPU time used by {@code thr}, or 0 if it cannot be determined.
>          || ci >     */
>          || ci >    private long cpuTime (Thread thr) {
>          || ci >		ThreadMXBean mxBean = ManagementFactory.getThreadMXBean();
>          || ci >        if (mxBean.isThreadCpuTimeSupported()) {
>          || ci >            try {
>          || ci >                return mxBean.getThreadCpuTime(thr.getId());
>          || ci >            } catch (UnsupportedOperationException e) {
>          || ci >            }
>          || ci >        }
>          || ci >        return 0;
>           | c  >    }
>           | c  >
>                >	private class CallableStatement implements Callable<Throwable> {
>                >        public Throwable call() throws Exception {
>                >            try {
>                >                fOriginalStatement.evaluate();
>                >            } catch (Exception e) {
>                >                throw e;
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

