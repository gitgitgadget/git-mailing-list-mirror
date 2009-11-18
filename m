From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 0/6] Second round of committag series
Date: Tue, 17 Nov 2009 22:22:24 -0800
Message-ID: <1258525350-5528-1-git-send-email-marcel@oak.homeunix.org>
References: <200906221318.19598.jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fge@one2team.net>,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 07:23:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAdwX-0001Od-UP
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 07:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbZKRGWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 01:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbZKRGWk
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 01:22:40 -0500
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:38092 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753729AbZKRGWh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 01:22:37 -0500
Received: (qmail 9474 invoked from network); 18 Nov 2009 06:22:43 -0000
Received: from adsl-76-246-148-73.dsl.pltn13.sbcglobal.net (marcel@76.246.148.73 with plain)
        by smtp126.sbc.mail.sp1.yahoo.com with SMTP; 17 Nov 2009 22:22:41 -0800 PST
X-Yahoo-SMTP: WxgK_ZmswBCwjfqSjWfXdnSm2tyuJVtcxuu8Nw--
X-YMail-OSG: M2oU.bYVM1mBqHNe2q1LrnwVxOh5AYE96oAiK.bf37K4HTb1B_OTBMx2Z.KdAoe9.Is.lcbDSGcjEYXGm.Hrzv029ipdh4Vs63_R8bBKhGYF4ZJiad8GJIu77Hi9F.rHZ5dm8FYRSLX.Yy786XpUPJDeNm6pUFlXT4N.fw6YUOUE7mOAp4XjngbvrNEyTUjgPkH9Ze2amXTEAuvk7mj3F2euFwb7rDen.5bBRwdhNsjHRSmJFrk_ew0cjr4YF1JBCn_LJ9o7620DlvnquIOOf_NNO9Ln4sXEJnvQMrQfc3WhTaAh
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1NAdvy-0004p6-Lr; Tue, 17 Nov 2009 22:22:30 -0800
X-Mailer: git-send-email 1.6.2
In-Reply-To: <200906221318.19598.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133141>

Thanks for the feedback.  I've added four more patches to the end of
the series and updated the first two.  My replies are below.

On Mon, 22 Jun 2009, Jakub Narebski wrote:
> On Fri, 19 June 2009, Marcel M. Cary wrote:
> 
> Thanks for diligently working on this issue.  Good work!
> 
> I see that it is an RFC, and not final submission, but just in case
> I'd like to remind you that some of information below should go into
> commit message, but some of it should I think go to comments (between
> "---" and diffstat).
> 
> > I want gitweb to hyperlink commits to my bug tracking system so that
> > information regarding the current status of a commit can be easily
> > cross-referenced.  For example, the QA and release status of a commit
> > cannot be inserted into the comment.  Maybe someday a "git notes"
> > feature will help with this, but for now, my organization has a
> > separate bug tracking system.  Other repository browsers such as
> > unfuddle and websvn support similar features.
> 
> The paragraph above should, I think, be made more clear.  You don't
> need to mention what you don't do; the comment about "git notes" should
> be not in commit message but in comments section.
> 
> What you want to have is to have some markers in commit message 
> (committags) hyperlinked; namely you want notifications about bug/issue
> numbers in the commit message hyperlinked to appropriate bugtracker/issue
> tracker URL.  Do I understand this correctly?

I'm not sure I would call the context of the bug numbers
"notifications".  A good example of what I'm looking for is to
hyperlink "Resolves-bug: 1234" to
http://bugzilla.example.com/show_bug.cgi?bug_id=1234.  I suppose this
could be seen as a notification of bug 1234's resolution, except that
I expect the more complex bugs (bugs, issues, and features) to require
several commits to resolve, each of which I'd like tagged with that
bug number, and so the bug would not really be resolved after the
first such commit.

> I tried here to reword what you said, to come up with better commit
> message for a future final submission.

I've rewritten the commit message paragraph as you suggested.  Is it
now more inline with what you'd like to see?

> > Since the bug hyperlinking feature was previously discussed as part of
> > "committags," a more general mechanism to embellish commit messages,
> > implement the more general mechanism instead, including the following
> > capabilities:
> 
> Well, I think that the fact that it would be not much harder to create
> general mechanism for commit message transformation, than to add 
> suitably generic and well customizable support for bugtracker 
> 'committags'.

So far, the biggest difficulty in generalizing the bugzilla hyperlink
feature has been the interaction between two or more commit tag
transformations -- how to structure them so they are composable but
decoupled.

> > * Hyperlinking mentions of bug IDs to Bugzilla
> > * Hyperlinking URLs
> > * Hyperlinking Message-Ids to a mailing list archive
> > * Hyperlinking commit hashes as before by default, now with a
> >   configurable regex
> > * Defining new committags per gitweb installation
> 
> Well, there is one _implicit_ (but important) commit message 
> transformation (filter) for display, which has to be always present[1],
> namely HTML escaping.  We make use of the fact that you can do
> HTML escaping before doing the only currently supported committag, 
> namely hyperlinking (shortened) SHA-1 to 'object' gitweb URL, but for
> other committags like mentioned "Message-Id to mail archive" committag
> (filter) it would make them more difficult.

The original patch still did the HTML escaping.  I don't see much
value in implementing this transformation as a committag since it
wouldn't be useful to configure it, and I don't really see it making
the code more clear or concise.  Did you have any particular reasons?

> Also one might consider vertical whitespace simplification (removing
> leading empty lines, compacting empty lines to single empty line 
> between paragraphs), and syntax highlighting signoff lines to be
> a kind of commit message filter like mentioned above committags
> (see git_print_log() subroutine).
> 
> Although probably vertical whitespace simplification should be not
> made into commit message filter, as it is used not for all views.
> 
> > 
> > Since different repositories may use different bug tracking systems or
> > mailing list archives, the URL parameter may be configured
> > per-repository without reiterating the regexes.  To accomodate
> > different conventions, regexes may also be configured per-project.
> 
> Also list of supported committags is separated from the list of 
> committags used[1]; just like it is done for snapshot formats.
> This could be mentioned in final commit message.
> 
> [1] well, sequence rather than list in this case, as here
>     ordering does matter a bit
> 
> > 
> > This patch is heavily based on discussions and code samples from the
> > Git list:
> > 
> > 	[RFC/PATCH] gitweb: Add committags support, Sep 2006
> > 	http://thread.gmane.org/gmane.comp.version-control.git/27504
> > 
> > 	[RFC] gitweb: Add committags support (take 2), Dec 2006
> > 	http://thread.gmane.org/gmane.comp.version-control.git/33150
> > 
> > 	[RFC] Configuring (future) committags support in gitweb, Nov 2008
> > 	http://thread.gmane.org/gmane.comp.version-control.git/100415
> 
> Hmmm... should this be put in final commit message, or only in comment
> to the patch (should this be in commit history of git repository)?

I'll exclude the mailing list references from the commit message since
they describe how I arrived at this set of changes rather than
describing the changes themselves.

> > Some issues I considered but punted:
> > 
> > * Should this configuration try to follow the bugtraq spec?
> > 
> >   As far as I know, only subversion implements it.  Separation of
> >   regexes by a newline would be a little awkward in the git config.
> >   And it is broader than just hyperlinking bugs: it also encompasses
> >   GUI bug ID form fields.  So gitweb would only implement a subset.
> 
> I didn't even know that there is such spec.  Were you talking about
> http://tortoisesvn.net/issuetracker_integration or do you have different
> URL in mind?

That is the Bugtraq spec, although I had been looking at a text-only
version of it at the time.  I can't seem to find the text-only
document, but I think that one explains it just as well.

> >   The gitweb configuration mechanism currently only reads
> >   keys starting with "gitweb.", but these parameters would be more
> >   broadly applicable, potentially to git-gui, for example.
> 
> Actually the fact that gitweb reads only keys in the 'gitweb' section
> from config is just a convention.  There were (are) no config variables
> in other places (other sections) which would be of interest to gitweb.
> 
> > 
> >   However, it *would* be useful for Git tools to standardize on
> >   config keys and interpretations of regexes and url formats.  For
> >   example, git-gui might be able to hyperlink the same text as gitweb,
> >   and even show a separate bugID field when composing a commit
> >   message.
> 
> This is I think a very good idea... but I think idea which 
> implementation can be left for later.

Very well then, I'll leave everything related to the other git tools
for later.

> > 
> > * I would prefer the regex match against the whole commit message.
> > 
> >   This would allow the regex to insist that a bug reference occur
> >   on the first line or non-first line of the commit message.  However,
> >   even if we concatenated the log lines for the first committag,
> >   subsequent committags would see the text broken up.
> > 
> >   Also, it would allow the regex to match a phrase split across a
> >   line boundary, as dicussed at some length in the first thread,
> >   but again, only if no prior committags had interfered.
> > 
> >   This could happen in a later patch.
> 
> Well, the change should be fairly easy: just concatenate lines before
> passing them as single element list to commit message filters.  OTOH
> you would have to take care of end of line characters in committags
> regexps.

Yes, it seems manageable to process the whole commit message at once
rather than line by line.  I've made this change to support patch 4 of
this series.

> > * I would prefer the site admin have a way to let a repository
> >   owner define new committags, which means having a way to specify
> >   the 'sub' key from the repo config or having a flexible default.
> 
> Perhaps, following your earlier suggestion to make committags supported
> also by other tools, gitweb (and e.g. git-gui / gitk) use config 
> variable committag.<name>.<key> (where <key> can be 'pattern' or 'url';

This is a great example of the kind of decision I'd like to make
up-front to avoid breaking existing configs later:
gitweb.committag.<name>.<key> vs. committag.<name>.<key>.  I'm not
very interested in adding the git-gui / gitk feature myself.  Is
anyone actually interested in this feature?  If not, perhaps it should
stay under gitweb.committag.<name>.<key>.  And even if there is
interest in the git-gui / gitk features, perhaps it would make sense
to start with the gitweb-specific version of the config variable names
and once there is cross-tool support, keep those configs as overrides
for gitweb only?

> although I wonder if we can allow 'pattern' as malicious user can do
> a DoS attack against gitweb / server using badly behaved regexp).

Yes, I imagine there is a risk of abuse in allowing patterns to be
configurable.  That's one reason why the site config can disallow
per-project configuration of regexes.  Are you suggesting there be a
separate flag to allow override of regexes than to allow override of
other parameters?  For example, with a separate flag for regexes,
repo.or.cz could allow you to configure the bug tracker URL but not
the bug regex.  I've added very fine grain support for allowing only
some options to be overridden in patch 3 of this series.

> > The bugtraq and some of the regex questions must be decided now to
> > avoid breaking gitweb configs later.
> 
> True.
> 
> > 
> > Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
> > ---
> >  gitweb/INSTALL                         |    4 +
> >  gitweb/gitweb.perl                     |  221 +++++++++++++++++++++++++++++++-
> >  t/t9500-gitweb-standalone-no-errors.sh |  150 +++++++++++++++++++++-
> >  3 files changed, 367 insertions(+), 8 deletions(-)
> > 
> > diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> > index 18c9ce3..223e39e 100644
> > --- a/gitweb/INSTALL
> > +++ b/gitweb/INSTALL
> > @@ -123,6 +123,10 @@ GITWEB_CONFIG file:
> >  	$feature{'snapshot'}{'default'} = ['zip', 'tgz'];
> >  	$feature{'snapshot'}{'override'} = 1;
> >  
> > +	$feature{'committags'}{'default'} = ['sha1', 'url', 'bugzilla'];
> > +	$feature{'committags'}{'override'} = 1;
> > +
> > +
> >  
> >  Gitweb repositories
> >  -------------------
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 1e7e2d8..c66fdf3 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -195,6 +195,81 @@ our %known_snapshot_format_aliases = (
> >  	'x-zip' => undef, '' => undef,
> >  );
> >  
> 
> I understand that comments such as one below would be not present in
> a final submission, and they are here to provide running commentary for
> code, isn't it?

Yes.  I've removed the running commentary, since it seems to be in the
way.

> > +# Could call these something else besides committags... embellishments,
> > +# patterns, rewrite rules, ?
> 
> They are "commit filters", or "commit message filters" (or 'formatters',
> or 'processors'; they are not 'parsers').  
> 
> The name 'committag' was first introduced as far as I remember in xmms2
> fork of gitweb (in old times when gitweb was separate project, and not
> part of git repository).

Sounds as though there is no interest in changing the name to
something that more clearly describes the feature (asside from my own,
but I'd like a little more validation...).  Let's stick with
committag.

> > +#
> > +# In general, the site admin can enable/disable per-project configuration
> > +# of each committag.  Only the 'options' part of the committag is configurable
> > +# per-project.
> 
> See above caveat about allowing to customize 'regexp'/'pattern' part
> in untrusted environment; you can construct regexp which has exponential
> behavior.
> 
> > +#
> > +# The site admin can of course add new tags to this hash or override the
> > +# 'sub' key if necessary.  But such changes may be fragile; this is not
> > +# designed as a full-blown plugin architecture.
> > +our %committags = (
> 
> 
> You should put the comments here about supported keys, similar to the
> one for %known_snapshot_formats and %feature hashes.

I believe I've addressed your request by adding a comment that
applies to all tags.  Because of the similarity of the tags, I don't
think it would be very useful to do this for each tag.  Does the 'url'
option used on two of the tags need further explanation?

> > +	# Link Git-style hashes to this gitweb
> > +	'sha1' => {
> > +		'options' => {
> > +			'pattern' => qr/\b([0-9a-fA-F]{8,40})\b/,
> > +		},
> > +		'override' => 0,
> 
> Shouldn't 'override' key be better last?

I liked 'override' close to the 'options' hash because that is what it
controls.  The 'sub' key was not overridable per-project no matter how
you configure gitweb.  Now it is, so maybe now 'override' could go
last.  Or first.  But really, I don't think the order matters much.

> > +		'sub' => sub {
> > +			my ($opts, @match) = @_;
> > +			\$cgi->a({-href => href(action=>"object", hash=>$match[1]),
> > +			          -class => "text"}, esc_html($match[0], -nbsp=>1));
> > +		},
> 
> Style: although there is commonly used idiom to use 'sub { <expr>; }'
> for a wrapper subroutines (e.g. 'sub { [] }' in Moose examples), one
> should use explicit "return" statement instead of relying on Perl 
> behavior of returning last statement in a block.
> 
> See Perl::Critic::Policy::Subroutines::RequireFinalReturn policy in
> Perl::Critic (perlcritic.com).  "Perl Best Practices" says:
> 
>   Subroutines without explicit 'return' statements at their ends can be
>   confusing. It can be challenging to deduce what the return value will be.
> 
> > +	},
> > +	# Link bug/features to Mantis bug tracker using Mantis-style contextual cues
> > +	'mantis' => {
> > +		'options' => {
> > +			'pattern' => qr/(?:BUG|FEATURE)\((\d+)\)/,
> > +			'url' => 'http://bugs.xmms2.xmms.se/view.php?id=',
> 
> I don't think we want to put such URL here.  Please check if Mantis 
> documentation uses some specific links, or follow RFC conventions and
> use 'example.com' as hostname (e.g. 'bugs.example.com').

Ok, I'll use a neutral URL for the mantis default.

> By the way the bugtraq proposal you mentioned uses placeholder in URL
> for putting issue number (%BUGID%).  Perhaps gitweb should do the same
> here.

I'd rather use a regex-style or sprintf-style syntax that could be
used by all committags.  I started with just an opaque string to
prepend to the bug ID because it was the simplest way to fulfill my
requirements, but it's certainly plausible that a BTS would want urls
like "example.com/bug/1234/detail" in which case the prepending
strategy isn't sufficient.  Again, ideally we'd decide now whether to
use '$1' or '%s' so we don't break configs later.  If the bugtraq
feature is implemented at some point, those config parameters can
still use the %BUGID% placeholder.

> > +		},
> > +		'override' => 0,
> > +		'sub' => \&hyperlink_committag,
> > +	},
> > +	# Link mentions of bug IDs to bugzilla
> > +	'bugzilla' => {
> > +		'options' => {
> > +			'pattern' => qr/bug\s+(\d+)/,
> > +			'url' => 'http://bugzilla.kernel.org/show_bug.cgi?id=',
> 
> The same comment as above.
> 
> > +		},
> > +		'override' => 0,
> > +		'sub' => \&hyperlink_committag,
> > +	},
> > +	# Link URLs
> > +	'url' => {
> > +		'options' => {
> > +			# Avoid matching punctuation that might immediately follow
> > +			# a url, is not part of the url, and is allowed in urls,
> > +			# like a full-stop ('.').
> > +			'pattern' => qr!(http|ftp)s?://[-_a-zA-Z0-9\@/&=+~#<>;%:.?]+
> > +			                               [-_a-zA-Z0-9\@/&=+~#<>]!x,
> 
> If you took this regexp from some place (like blog), it would be good
> to mention URL here, to be able to check more detailed explanation of
> construction of this URL-catching regexp.

Actually, I think I started with a URL regex mentioned on-list and
then tweaked it until I thought it worked well enough.

Most of the regexes I found on the web had issues.  They tended to be
too long because they were trying to precisely validate the URL or
because they were trying to parse all the different parts of the url,
or they did not deal with the trailing punctuation problem: I don't
want the period (".") to be highlighted in this context: "See
http://example.com/foo."  I think it's a valid URL even with the
period, but typically the period will not be part of the URL.  On the
other hand, "http://example.com/foo.html" should be completely
highlighted in spite of the period.

> Should we also support irc://, nntp:// (pseudo)protocols? What about
> git:// ?

I'va added more schemes, but it's also possible to leave those as a
customization.  In my organization, it would be very uncommon for
someone to follow a URL with any of those schemes.  I'd be willing to
allow any scheme that matches "[a-z]+://".  I don't care about stuff
like "data:literal+text", and "mailto:" is also less interesting to
me.  (I'd rather add a committag to match the email address without a
"mailto:".)  And then there's those pesky windows file sharing
thingies like '\\server\directory' that work like URLs in Internet
Explorer.  I'd rather not include them in the URL committag... but a
site admin could certainly configure a committag for it.  Here's a
list schemes for which KDE allegedly supports retreival of metadata:

bluetooth, fish, ftp, imap(s), invitation, iso, ldap(s), mac, mdns,
nfs, nntp(s), nxfish, obex, pop3(s), print, printdb, sdp, service,
sftp, slp, smb, smtp(s), webdav(s)

I wouldn't want to enumerate all of those, but, in addition to the
three you suggest, these look most useful to me: sftp, smb, webdav(s),
nfs.  So really I think it comes down to whether we want to enumerate
them or just match any scheme, and risk matching something that was
not intended as a URL.  And if we enumerate, how many do we want to
list.

What do you think of the new list of schemes in patch 1?  I've
included several more than before.

> > +		},
> > +		'override' => 0,
> > +		'sub' => sub {
> > +			my ($opts, @match) = @_;
> > +			return
> > +				\$cgi->a({-href => $match[0],
> > +				          -class => "text"},
> > +				         esc_html($match[0], -nbsp=>1));
> > +		},
> 
> Here you use explicit return.
> 
> > +	},
> > +	# Link Message-Id to mailing list archive
> > +	'messageid' => {
> > +		'options' => {
> > +			# The original pattern, which I don't really understand
> > +			#'pattern' => qr!(?:message|msg)-id:?\s+<([^>]+)>;!i,
> > +			'pattern' => qr!(?:message|msg)-?id:?\s+(<[^>]+>)!i,
> 
> Errr... how original patter is different from the one used?  Also above
> comment should be removed in final submission.

The most important change is that the semicolon is removed.  I
also made the dash optional.  It wasn't clear to me whether this was
intended to match a header-style reference:

    Message-Id: <asdf@example.com>

Or a casual mention:

    In msgid <asdf@example.com>, John Doe says...

But I like the latter, and would like the former to still be
supported.

> > +			'url' => 'http://news.gmane.org/find-root.php?message_id=',
> 
> Same comment about generic URL... although on the other hand perhaps
> having a few examples of mail archive sites which support finding 
> messages by Message-Id could be a good idea.
> 
> BTW. you can write 'http://mid.gmane.org/' instead...

Thanks for the tip.  Is there another common mail archive site
that allows looking up emails by message-id?  If so, I'd love to
mention the url in the comment for that committag.  I think we need to
strike a balance between having things work with minimal configuration
and avoiding the promotion of specific web sites that won't make sense
for most sites using a particular committag.  So, unless there is a
whole slew of web sites that provide this feature, I'd suggest leaving
the specific URL in.

> > +		},
> > +		'override' => 0,
> > +		# The original version didn't include the "msg-id" text in the
> > +		# link text, but this does.  In general, I think a little more
> > +		# context makes for better link text.
> 
> I guess that is the result of using generic hyperlink_committag() 
> subroutine here.  (This comment should be removed or reworded in final
> submitted version, I think.)

Yes, although if we decided it was sub-optimal link text, I'd be
happy to use a less generic mechanism.

> BTW. it would be much easier with Perl6-ish (or Perl 5.10.x) named
> captures (named groups):
> 
> 	'pattern' => qr!(?:message|msg)-?id:?\s+(?P<query><[^>]+>)!i,
> 
> or something like that.

I like the notion of names rather than numberic indices, but I'm
hesitant to require site admins to use unfamiliar Perl regex syntax to
configure committags.  Of two admins I asked, neither could make sense
of the sample regex.  If wouldn't want a site admin to *have* to learn
new syntax to configure regexes.

> > +		'sub' => \&hyperlink_committag,
> > +	},
> > +);
> > +
> >  # You define site-wide feature defaults here; override them with
> >  # $GITWEB_CONFIG as necessary.
> >  our %feature = (
> > @@ -365,6 +440,21 @@ our %feature = (
> >  		'sub' => \&feature_patches,
> >  		'override' => 0,
> >  		'default' => [16]},
> > +
> > +	# The selection and ordering of committags that are enabled.
> > +	# Committag transformations will be applied to commit log messages
> > +	# in this order if listed here.
> 
> /this/given/
> 
> You need to mention somewhere that committag subroutines return a list
> of mixed scalar and reference to scalar elements, where using reference
> to scalar removes value from the chain of filters (including implicit
> final esc_html filter).

I chose to add that explanation in the section that describes the
configuration of committags rather than in this section that defines
the list of active committags.  Sound ok?

> > +
> > +	# To disable system wide have in $GITWEB_CONFIG
> > +	# $feature{'committags'}{'default'} = [];
> > +	# To have project specific config enable override in $GITWEB_CONFIG
> > +	# $feature{'committags'}{'override'} = 1;
> > +	# and in project config gitweb.committags = sha1, url, bugzilla
> > +	# to enable those three committags for that project
> 
> Just a thought: perhaps we should provide support for 'default' in
> config (which would currently be "sha1" or "sha1, url").

I didn't understand how this would be very useful until I added
the signoff committag.  The use case I see is that it allows the
gitweb distribution to adjust the base functionality, in this case by
pushing some functionality into a committag, without project owners
needing to reconfigure their repositories.  Site admins don't need
this because they can use "push" or "unshift" to preserve the
distributed committags, right?  The project owner should get the
distribution default, not the site default, when they write "default",
right?  Are there other use cases you had in mind?  A potential
implementation is in patch 6.

> See also comment text for 'snapshot' feature, which says:
> 
>   and in project config, a comma-separated list of [...] or 
>   "none" to disable.
> 
> > +	'committags' => {
> > +		'sub' => \&feature_committags,
> > +		'override' => 0,
> > +		'default' => ['sha1']},
> >  );
> >  
> >  sub gitweb_get_feature {
> > @@ -433,6 +523,18 @@ sub feature_patches {
> >  	return ($_[0]);
> >  }
> >  
> > +sub feature_committags {
> > +	my (@defaults) = @_;
> > +
> > +	my ($cfg) = git_get_project_config('committags');
> > +
> > +	if ($cfg) {
> > +		return ($cfg eq 'none' ? () : split(/\s*[,\s]\s*/, $cfg));
> > +	}
> > +
> > +	return @defaults;
> > +}
> 
> As this would be second feature which uses comma-separated (or for
> backward compatibility space separated) list of options, perhaps
> we should factor out this part into common helper subroutine named
> for example 'feature_list' or 'feature_multi' (like 'feature_bool').

Thanks for pointing out the opportunity to fold the feature list
functions together.

> > +
> >  # checking HEAD file with -e is fragile if the repository was
> >  # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
> >  # and then pruned.
> > @@ -814,6 +916,34 @@ $git_dir = "$projectroot/$project" if $project;
> >  our @snapshot_fmts = gitweb_get_feature('snapshot');
> >  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
> >  
> > +# ordering of committags
> > +our @committags = gitweb_get_feature('committags');
> > +
> > +# Merge project configs with default committag definitions
> > +gitweb_load_project_committags();
> 
> Good idea... although gitweb first defines and then uses subroutine,
> see evaluate_path_info().

Sounds like you're asking me to move the function call after the
function definition.  I've made the change, but I'm also curious to
know why you have that preference.  I sometimes find it less readable,
as in this case.

> > +
> > +# Load committag configs from the repository config file and and
> > +# incorporate them into the gitweb defaults where permitted by the
> > +# site administrator.
> > +sub gitweb_load_project_committags {
> > +	return if (!$git_dir);
> > +	my %project_config = ();
> > +	my %raw_config = git_parse_project_config('gitweb\.committag');
> 
> Why not do lazy-loading of a whole config here?  We use committag
> info only for project-specific actions in gitweb.

I thought the check for $git_dir would prevent loading it for
non-project-specific pages.  Even so, I suppose we might load the
config on a page like the shortlog page that doesn't need it.

> > +	foreach my $key (keys(%raw_config)) {
> > +		next if ($key !~ /gitweb\.committag\.[^.]+\.[^.]/);
> > +		my ($gitweb_prefix, $committag_prefix, $ctname, $option) =
> > +			split(/\./, $key, 4);
> > +		$project_config{$ctname}{$option} = $raw_config{$key};
> > +	}
> 
> And use created subroutines to handle config?

Are you saying I should be using other subroutines that already
exist in gitweb rather than implementing my own?  Are you thinking of
git_get_project_config?  If I understand correctly, it requires me to
enumerate all the config keys I want.  I'd rather not require the
committags to have a predetermined set of possible config keys.  I see
now that I could still call git_get_project_config to load data into
%config and access that directly... I didn't do it before because it
seems to violate some kind of abstraction.

> > +	foreach my $ctname (keys(%committags)) {
> > +		next if (!$committags{$ctname}{'override'});
> > +		foreach my $optname (keys %{$project_config{$ctname}}) {
> > +			$committags{$ctname}{'options'}{$optname} =
> > +				$project_config{$ctname}{$optname};
> > +		}
> > +	}
> > +}
> > +
> >  # dispatch
> >  if (!defined $action) {
> >  	if (defined $hash) {
> > @@ -1384,13 +1514,92 @@ sub file_type_long {
> >  sub format_log_line_html {
> >  	my $line = shift;
> >  
> > -	$line = esc_html($line, -nbsp=>1);
> > -	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
> > -		$cgi->a({-href => href(action=>"object", hash=>$1),
> > -					-class => "text"}, $1);
> > -	}eg;
> > +	# In this list of log message fragments, a string ref indicates HTML,
> > +	# and a string indicates plain text
> > +	my @list = ( $line );
> 
> Well, to be more exact string ref means that the string referenced is
> not to be processed by later filters, including final implicit esc_html.

Well... it means both not processing and HTML escaping.  The string
refs will also not be escaped in the final processing step.

> Perhaps it would be better to use less generic name than @list herem
> e.g. @process or something?

Sure.  I chose @message_fragments as the less generic name for @list.

> > -	return $line;
> > +COMMITTAG:
> > +	foreach my $ctname (@committags) {
> > +		next COMMITTAG unless exists $committags{$ctname};
> > +		my $committag = $committags{$ctname};
> > +
> > +		next COMMITTAG unless exists $committag->{'options'};
> > +		my $opts = $committag->{'options'};
> > +
> > +		next COMMITTAG unless exists $opts->{'pattern'};
> > +		my $pattern = $opts->{'pattern'};
> > +
> > +		my @newlist = ();
> > +
> > +	PART:
> > +		foreach my $part (@list) {
> > +			next PART if $part eq "";
> > +			if (ref($part)) {
> > +				push @newlist, $part;
> > +				next PART;
> > +			}
> > +
> > +			my $oldpos = 0;
> > +
> > +		MATCH:
> > +			while ($part =~ m/$pattern/gc) {
> > +				my ($prepos, $postpos) = ($-[0], $+[0]);
> > +				my $repl = $committag->{'sub'}->($opts, $&, $1);
> > +				$repl = "" if (!defined $repl);
> > +
> > +				my $pre = substr($part, $oldpos, $prepos - $oldpos);
> > +				push_or_append(\@newlist, $pre);
> > +				push_or_append(\@newlist, $repl);
> > +
> > +				$oldpos = $postpos;
> > +			} # end while [regexp matches]
> > +
> > +			my $rest = substr($part, $oldpos);
> > +			push_or_append(\@newlist, $rest);
> > +
> > +		} # end foreach (@list)
> > +
> > +		@list = @newlist;
> > +	} # end foreach (@committags)
> > +
> > +	# Escape any remaining plain text and concatenate
> > +	my $html = '';
> > +	for my $part (@list) {
> > +		if (ref($part)) {
> > +			$html .= $$part;
> > +		} else {
> > +			$html .= esc_html($part, -nbsp=>1);
> > +		}
> > +	}
> > +
> > +	return $html;
> > +}
> 
> Nice.

Hehe, that bit of code is mostly yours, which you posted on this list
ages ago. (:  I suppose we should try to get your signoff into the
first patch of the series?

> > +
> > +# Returns a ref to an HTML snippet that links the second
> > +# parameter to a URL formed from the first and last parameters.
> > +# This is a helper function used in %committags.
> > +sub hyperlink_committag {
> > +	my ($opts, @match) = @_;
> > +	return
> > +		\$cgi->a({-href => $opts->{url} . CGI::escape($match[1]),
> 
> $opts->{'url'} not $opts->{url}
> 
> '$cgi->escapeHTML' I think, not 'CGI::escape' (but I am not sure here).
> besides, we can always import 'escape'.
> 
> > +				  -class => "text"},
> > +				 esc_html($match[0], -nbsp=>1));
> > +}
> > +
> > +
> > +sub push_or_append (\@@) {
> 
> Hmmm... this would be first use of Perl subroutine prototypes in gitweb.
> But this is made to imitate 'push' built-in, so I think it is O.K.

Ok, I guess I'll leave the subroutine prototype in then.  I don't
understand all the implications, so if you think it'll work well
without the prototype, I'm happy to remove it.  This is code
that I think you posted to the list.

> > +	my $list = shift;
> > +
> > +	if (ref $_[0] || ! @$list || ref $list->[-1]) {
> > +		push @$list, @_;
> > +	} else {
> > +		my $a = pop @$list;
> > +		my $b = shift @_;
> > +
> > +		push @$list, $a . $b, @_;
> > +	}
> > +	# imitate push
> > +	return scalar @$list;
> >  }
> >  
> >  # format marker of refs pointing to given object
> > diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> > index d539619..37a127c 100755
> > --- a/t/t9500-gitweb-standalone-no-errors.sh
> > +++ b/t/t9500-gitweb-standalone-no-errors.sh
> > @@ -55,9 +55,9 @@ gitweb_run () {
> >  	# some of git commands write to STDERR on error, but this is not
> >  	# written to web server logs, so we are not interested in that:
> >  	# we are interested only in properly formatted errors/warnings
> > -	rm -f gitweb.log &&
> > +	rm -f resp.http gitweb.log &&
> >  	perl -- "$SCRIPT_NAME" \
> > -		>/dev/null 2>gitweb.log &&
> > +		> resp.http 2>gitweb.log &&
> >  	if grep "^[[]" gitweb.log >/dev/null 2>&1; then false; else true; fi
> >  
> 
> Well, if you begin to check _output_ of gitweb, then it should be put 
> in separate test, not t/t9500-gitweb-standalone-no-errors.sh which is
> only about no-errors... or change name of gitweb test.

I see there is some precedent for adding lib-foo.sh files.  Perhaps it
would be appropriate to move parts of the no-errors test into a
lib-gitweb.sh?  Like gitweb_init, most of gitweb_run, and maybe the
perl checks (which are that way for lib-git-svn.sh)?  I'm all for
separating the tests.  I don't like having to keep telling the test to
skip the first 85 cases when all I want to run is the committag stuff.

Actually, looks like Mark Rada already made a gitweb-lib.sh which was
exactly the same as the one I'd made except the name of the lib (vs.
lib-gitweb.sh) and the name of the file holding gitweb output.  I've
rebased onto those changes.

> I think I'm gonna leave this and the other feedback
> >  	# gitweb.log is left for debugging
> > @@ -702,4 +702,150 @@ test_expect_success \
> >  	 gitweb_run "p=.git;a=summary"'
> >  test_debug 'cat gitweb.log'
> >  
> > +# ----------------------------------------------------------------------
> > +# sha1 linking
> > +#
> > +echo hi > file.txt
> > +git add file.txt
> > +git commit -q -F - file.txt <<END
> > +Summary
> > +
> > +See also commit 567890ab
> > +	h=$(git rev-parse --verify HEAD) &&
> > +	gitweb_run "p=.git;a=commit;h=$h" &&
> 
> Actually you can just use "h=HEAD" or use query without 'h' parameter
> (which defaults to "HEAD") here.
 
Thanks for the tip, I'll use h=HEAD.
 
> > +	grep -q \
> > +		"commit&nbsp;<a class=\"text\" href=\".*\">567890ab</a>" \
> > +		resp.http
> > +'
> > +test_debug 'cat gitweb.log'
> > +test_debug 'grep 567890ab resp.http'
> 
> I'd rather use Test::* (e.g. Test::WWW::Mechanize::CGI) for that...
> but having some output test for gitweb, even in such simple form would
> certainly  be nice.

Would this mean people need to install some Mechanize stuff before
they can run the tests?  I think I'd rather avoid the dependency as
long as grep seems to do the trick.

> > +
> > +# ----------------------------------------------------------------------
> > +# bugzilla commit tag
> > +#
> > +
> > +echo foo > file.txt
> > +git add file.txt
> > +git commit -q -F - file.txt <<END
> > +Fix foo
> > +
> > +Fixes bug 1234 involving foo.
> > +END
> > +git config gitweb.committags 'sha1, bugzilla'
> > +test_expect_success 'bugzilla: enabled but not permitted' '
> > +	h=$(git rev-parse --verify HEAD) &&
> > +	gitweb_run "p=.git;a=commit;h=$h" &&
> > +	grep -F -q \
> > +		"Fixes&nbsp;bug&nbsp;1234&nbsp;involving" \
> > +		resp.http
> > +'
> > +test_debug 'cat gitweb.log'
> > +test_debug 'grep 1234 resp.http'
> > +
> > +echo '$feature{"committags"}{"override"} = 1;' >> gitweb_config.perl
> > +test_expect_success 'bugzilla: enabled' '
> > +	h=$(git rev-parse --verify HEAD) &&
> > +	gitweb_run "p=.git;a=commit;h=$h" &&
> > +	grep -F -q \
> > +		"Fixes&nbsp;<a class=\"text\" href=\"http://bugzilla.kernel.org/show_bug.cgi?id=1234\">bug&nbsp;1234</a>&nbsp;involving" \
> > +		resp.http
> > +'
> 
> Hmmm...
> 

?



Marcel M. Cary (6):
  gitweb: Hyperlink various committags in commit message with regex
  gitweb: Add second-stage matching of bug IDs in bugzilla committag
  gitweb: Allow finer-grained override controls for committags
  gitweb: Allow committag pattern matches to span multiple lines
  gitweb: Allow per-repository definition of new committags
  gitweb: Add _defaults_ keyword for feature lists in project config

 gitweb/INSTALL               |   16 ++
 gitweb/gitweb.perl           |  404 +++++++++++++++++++++++++++++++++++++-----
 t/t9502-gitweb-committags.sh |  309 ++++++++++++++++++++++++++++++++
 3 files changed, 681 insertions(+), 48 deletions(-)
 create mode 100755 t/t9502-gitweb-committags.sh
