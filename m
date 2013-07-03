From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Review of git multimail
Date: Wed, 03 Jul 2013 02:10:00 +0200
Message-ID: <51D36BD8.1060909@alum.mit.edu>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 02:10:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuAeC-00020n-9N
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 02:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab3GCAKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 20:10:06 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:46248 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756227Ab3GCAKE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jul 2013 20:10:04 -0400
X-AuditID: 12074411-b7f296d000001209-19-51d36bdb9165
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 29.11.04617.BDB63D15; Tue,  2 Jul 2013 20:10:03 -0400 (EDT)
Received: from [192.168.69.140] (p57A25F24.dip0.t-ipconnect.de [87.162.95.36])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r630A1NY030574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Jul 2013 20:10:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <1372793019-12162-1-git-send-email-artagnon@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqHs7+3KgwdxDGharZj5mt+i60s3k
	wOSxc9Zddo/Pm+QCmKK4bZISS8qCM9Pz9O0SuDN23H3KUvBnNlPF3R2xDYx/zzJ2MXJySAiY
	SLyZ1c0MYYtJXLi3ng3EFhK4zCjxbHoohH2WSWLhXycQm1dAW6Lj3VOwXhYBVYmt/XPB6tkE
	dCUW9TQzdTFycIgKhElc+a0KUS4ocXLmExaQsAhQybNV3iBhZgElif7Lv1lAbGEBFYmLi1cz
	Q2xykji3/gA7iM0p4CzxZ+kdVoh6HYl3fQ+YIWx5ie1v5zBPYBSYhWTDLCRls5CULWBkXsUo
	l5hTmqubm5iZU5yarFucnJiXl1qka6qXm1mil5pSuokREqSCOxhnnJQ7xCjAwajEw+vw7FKg
	EGtiWXFl7iFGSQ4mJVFeAWCIC/El5adUZiQWZ8QXleakFh9ilOBgVhLh1coCyvGmJFZWpRbl
	w6SkOViUxHn5lqj7CQmkJ5akZqemFqQWwWRlODiUJHjFQYYKFqWmp1akZeaUIKSZODhBhnNJ
	iRSn5qWkFiWWlmTEg6I0vhgYpyApHqC938D2Fhck5gJFIVpPMVpyTD675T0jx4EfIPLHmW3v
	GYVY8vLzUqXEeZVB9gmANGSU5sGtg6WqV4ziQN8L8/4GGcsDTHNwU18BLWQCWii9/BLIwpJE
	hJRUA6PR9l/Ju2/88fK50HHtE9PXK6yWIf80znjMOLXl3+s5a9weitu1TW7957ArMCPKfOVk
	cZ5gj+T9gZ9277VNYzyzk/fU9G0/Twbk6f651lc/86bWyZAl7ulnL3x/+98v3fUA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229451>

On 07/02/2013 09:23 PM, Ramkumar Ramachandra wrote:
> I figured that we should quickly read through git-multimail and give
> it an on-list review.  Hopefully, it'll educate the list about what
> this is, and help improve the script itself.

Wonderful, thanks!

> Sources: https://github.com/mhagger/git-multimail
> 
> git_multimail.py wrote:
>> #! /usr/bin/env python2
> 
> Do all distributions ship it as python2 now?

No, but nor is "python" always Python version 2.x (I believe that Arch
Linux now installs Python 3 as "python").  This topic was discussed here
[1].  Basically, my reasoning is that (a) PEP 394 [2] says that
"python2" is the correct name for a Python 2.x interpreter, (b) I
believe that other distros are moving in that direction, and (c) if the
script says "python2" but no python2 is installed, the error is pretty
obvious, whereas if the script says "python" and that is actually Python
3.x, the error would be more cryptic.

>> class CommandError(Exception):
>>     def __init__(self, cmd, retcode):
>>         self.cmd = cmd
>>         self.retcode = retcode
>>         Exception.__init__(
>>             self,
>>             'Command "%s" failed with retcode %s' % (' '.join(cmd), retcode,)
> 
> So cmd is a list.

Yes, commands are always lists in my code because it is less error-prone
than trying to quote arguments correctly for the shell.  Do you think I
should document that here, or elsewhere, or everywhere, or ...?

>> class ConfigurationException(Exception):
>>     pass
> 
> Dead code?

No, this defines an exception class that inherits all of its methods
(including its constructors) from Exception.  This is useful because an
exception of type ConfigurationException is distinguishable from other
types of Exceptions, and can be caught using "except
ConfigurationException, e".

>> def read_git_output(args, input=None, keepends=False, **kw):
>>     """Read the output of a Git command."""
>>
>>     return read_output(
>>         ['git', '-c', 'i18n.logoutputencoding=%s' % (ENCODING,)] + args,
>>         input=input, keepends=keepends, **kw
>>         )
> 
> Okay, although I'm wondering what i18n.logoutputencoding has to do with anything.

Ultimately, a lot of the output of these commands is going to be
inserted into an email that claims to be UTF-8, so this is here to
hopefully avoid at least one source of non-UTF-8 text.

> [...]
>> class Config(object):
>>     def __init__(self, section, git_config=None):
>>         """Represent a section of the git configuration.
>>
>>         If git_config is specified, it is passed to "git config" in
>>         the GIT_CONFIG environment variable, meaning that "git config"
>>         will read the specified path rather than the Git default
>>         config paths."""
>>
>>         self.section = section
>>         if git_config:
>>             self.env = os.environ.copy()
>>             self.env['GIT_CONFIG'] = git_config
>>         else:
>>             self.env = None
> 
> Okay.
> 
>>     @staticmethod
>>     def _split(s):
>>         """Split NUL-terminated values."""
>>
>>         words = s.split('\0')
>>         assert words[-1] == ''
>>         return words[:-1]
> 
> Ugh.  Two callers of this poorly-defined static method: I wonder if
> we'd be better off inlining it.
> 
>>     def get(self, name, default=''):
>>         try:
>>             values = self._split(read_git_output(
>>                     ['config', '--get', '--null', '%s.%s' % (self.section, name)],
>>                     env=self.env, keepends=True,
>>                     ))
> 
> Wait, what is the point of using --null and then splitting by hand
> using a poorly-defined static method?  Why not drop the --null and
> splitlines() as usual?

To avoid confusion if a single config value contains end-of-line
characters.  In this case we are using --get, so only a single value is
allowed anyway, and presumably we could take the output and strip a
single last '\n' from it.  But null-terminated output is simply easier
to handle in general and I don't see an advantage to avoiding its usage.

>>             assert len(values) == 1
> 
> When does this assert fail?

It shouldn't; treat this as a verification that everything is sane.  For
example if I had mistakenly used splitlines(), then the assertion could
have failed; without the assertion the next line would have masked the
error ;-)

>>             return values[0]
>>         except CommandError:
>>             return default
> 
> If you're emulating the dictionary get method, default=None.  This is
> not C, where all codepaths of the function must return the same type.

You are right.  When I designed this class, I though that the empty
string would often be convenient.  But I just reviewed callers, and many
(most?) of them explicitly set the default to None anyway.  I will
change this.

> [...]
>>     def get_all(self, name, default=None):
>>         """Read a (possibly multivalued) setting from the configuration.
>>
>>         Return the result as a list of values, or default if the name
>>         is unset."""
>>
>>         try:
>>             return self._split(read_git_output(
>>                 ['config', '--get-all', '--null', '%s.%s' % (self.section, name)],
>>                 env=self.env, keepends=True,
>>                 ))
>>         except CommandError, e:
> 
> CommandError as e?

The new syntax is not available before Python 2.6.  It will have to be
changed when we try to support Python 3.x, but until then the change
wouldn't bring any benefits and would definitely prevent the script from
running under Python 2.4 or 2.5 (which are currently supported).

>>             if e.retcode == 1:
> 
> What does this cryptic retcode mean?

According to git-config(1), it means "the section or key is invalid" and
empirically this is the error code you get when you try to read a key
that is not defined.  I will add a comment.

>>                 return default
>>             else:
>>                 raise
> 
> raise what?

This is the Python construct to re-throw the exception that was caught
in the catch block containing it; i.e., the CommandError from a few
lines earlier.

> You've instantiated the Config class in two places: user and
> multimailhook sections.  Considering that you're going to read all the
> keys in that section, why not --get-regexp, pre-load the configuration
> into a dictionary and refer to that instead of spawning 'git config'
> every time you need a configuration value?

Yes, it's on my todo list.

>>     def get_recipients(self, name, default=None):
>>         """Read a recipients list from the configuration.
>>
>>         Return the result as a comma-separated list of email
>>         addresses, or default if the option is unset.  If the setting
>>         has multiple values, concatenate them with comma separators."""
>>
>>         lines = self.get_all(name, default=None)
>>         if lines is None:
>>             return default
>>         return ', '.join(line.strip() for line in lines)
> 
> Ugh.

?

>>     def set(self, name, value):
>>         read_git_output(
>>             ['config', '%s.%s' % (self.section, name), value],
>>             env=self.env,
>>             )
>>
>>     def add(self, name, value):
>>         read_git_output(
>>             ['config', '--add', '%s.%s' % (self.section, name), value],
>>             env=self.env,
>>             )
>>
>>     def has_key(self, name):
>>         return self.get_all(name, default=None) is not None
>>
>>     def unset_all(self, name):
>>         try:
>>             read_git_output(
>>                 ['config', '--unset-all', '%s.%s' % (self.section, name)],
>>                 env=self.env,
>>                 )
>>         except CommandError, e:
>>             if e.retcode == 5:
>>                 # The name doesn't exist, which is what we wanted anyway...
>>                 pass
>>             else:
>>                 raise
>>
>>     def set_recipients(self, name, value):
>>         self.unset_all(name)
>>         for pair in getaddresses([value]):
>>             self.add(name, formataddr(pair))
> 
> Dead code?

git_multimail is used as a library by migrate-mailhook-config, and that
script uses these methods.

>> def generate_summaries(*log_args):
>>     """Generate a brief summary for each revision requested.
>>
>>     log_args are strings that will be passed directly to "git log" as
>>     revision selectors.  Iterate over (sha1_short, subject) for each
>>     commit specified by log_args (subject is the first line of the
>>     commit message as a string without EOLs)."""
>>
>>     cmd = [
>>         'log', '--abbrev', '--format=%h %s',
>>         ] + list(log_args) + ['--']
> 
> What is log_args if not a list?

It is a tuple and therefore needs to be converted to a list here.

> But yeah, log is the best way to generate summaries.
> 
> [...]
>> class GitObject(object):
>>     def __init__(self, sha1, type=None):
>>         if sha1 == ZEROS:
>>             self.sha1 = self.type = self.commit = None
>>         else:
>>             self.sha1 = sha1
>>             self.type = type or read_git_output(['cat-file', '-t', self.sha1])
>>
>>             if self.type == 'commit':
>>                 self.commit = self
>>             elif self.type == 'tag':
>>                 try:
>>                     self.commit = GitObject(
>>                         read_git_output(['rev-parse', '--verify', '%s^0' % (self.sha1,)]),
>>                         type='commit',
>>                         )
>>                 except CommandError:
>>                     self.commit = None
>>             else:
>>                 self.commit = None
>>
>>         self.short = read_git_output(['rev-parse', '--short', sha1])
> 
> Just rev-parse --verify --short $SHA1^0: if it resolves, set
> self.short; one liner?

I don't follow.  We need both the long and the short SHA-1s to fill in
the templates.  What code exactly do you propose to replace with your
one-liner?

>>     def get_summary(self):
>>         """Return (sha1_short, subject) for this commit."""
>>
>>         if not self.sha1:
>>             raise ValueError('Empty commit has no summary')
> 
> What is the point of letting the user instantiate a GitObject without
> a valid .sha1 in the first place?

'0'*40 is passed to the post-receive script to indicate "no object"; for
example, a branch deletion is represented as

0123456789abcdef0123456789abcdef01234567
0000000000000000000000000000000000000000 refs/heads/branch

It is convenient to treat this as if it were a GitObject.
GitObject.__nonzero__() (which is called if a GitObject is evaluated in
a boolean context) returns False for these non-objects.

>>         return iter(generate_summaries('--no-walk', self.sha1)).next()
> 
> Not exactly fond of this, but I don't have a concrete replacement at
> the moment.
> 
> [...]
> Okay.
> 
>>     def __str__(self):
>>         return self.sha1 or ZEROS
> 
> I wonder what value this adds when .short is around.

The full object name is used in the X-Git-{Oldrev,Newrev} email headers
and probably in some error messages and stuff.

>> class Change(object):
>>     """A Change that has been made to the Git repository.
>>
>>     Abstract class from which both Revisions and ReferenceChanges are
>>     derived.  A Change knows how to generate a notification email
>>     describing itself."""
>>
>>     def __init__(self, environment):
>>         self.environment = environment
>>         self._values = None
>>
>>     def _compute_values(self):
>>         """Return a dictionary {keyword : expansion} for this Change.
>>
>>         Derived classes overload this method to add more entries to
>>         the return value.  This method is used internally by
>>         get_values().  The return value should always be a new
>>         dictionary."""
>>
>>         return self.environment.get_values()
> 
> Why is this an "internal function"?  What is your criterion for
> internal versus non-internal?

This method is meant to be overridden by derived classes to affect the
map returned by get_values().  But elsewhere get_values() should be
called, not this method (because get_values() memoizes its return value).

>>     def get_values(self, **extra_values):
>>         """Return a dictionary {keyword : expansion} for this Change.
>>
>>         Return a dictionary mapping keywords to the values that they
>>         should be expanded to for this Change (used when interpolating
>>         template strings).  If any keyword arguments are supplied, add
>>         those to the return value as well.  The return value is always
>>         a new dictionary."""
>>
>>         if self._values is None:
>>             self._values = self._compute_values()
>>
>>         values = self._values.copy()
>>         if extra_values:
>>             values.update(extra_values)
>>         return values
> 
> Unsure what this is about.

The dictionary is mainly used to provide values that can be interpolated
into the email templates.  It also has the advantage that it is only
called once, and then its value is used multiple times, which limits the
amount of boilerplate needed for derived classes to override the getter
methods without forcing those methods to be called many times.

> [...]
>>     def expand_header_lines(self, template, **extra_values):
>>         """Break template into lines and expand each line as an RFC 2822 header.
>>
>>         Encode values and split up lines that are too long.  Silently
>>         skip lines that contain references to unknown variables."""
>>
>>         values = self.get_values(**extra_values)
>>         for line in template.splitlines(True):
>>             (name, value) = line.split(':', 1)
>>             value = value.rstrip('\n\r')
> 
> Doesn't splitlines() make the rstrip() redundant?

As written it doesn't because I pass keepends=True to splitlines().  But
if I remove the keepends argument then I can indeed drop the rstrip().
Will change.

>>             try:
>>                 value = value % values
>>             except KeyError, e:
>>                 if DEBUG:
>>                     sys.stderr.write(
>>                         'Warning: unknown variable %r in the following line; line skipped:\n'
>>                         '    %s'
>>                         % (e.args[0], line,)
>>                         )
> 
> If DEBUG isn't on, you risk leaving the value string interpolated
> without even telling the user.  What does it mean to the end user?

There are some "nice-to-have" values in the templates that are not
necessary and might be missing if the user hasn't gone to the trouble to
configure every last setting.  For example, if no emaildomain is defined
then the pusher_email cannot be determined, resulting in the Reply-To
header being omitted.

My assumption is that a sysadmin would turn on DEBUG when testing the
script, check that any missing headers are uninteresting, and then turn
off DEBUG for production use so that users don't have to see the
warnings every time they push.

If you have another suggestion, let me know.

>>             else:
>>                 try:
>>                     h = Header(value, header_name=name)
>>                 except UnicodeDecodeError:
>>                     h = Header(value, header_name=name, charset=CHARSET, errors='replace')
>>                 for splitline in ('%s: %s\n' % (name, h.encode(),)).splitlines(True):
>>                     yield splitline
> 
> Not elated by this exception cascading, but I suppose it's cheaper
> than actually checking everything.
> 
>>     def generate_email_header(self):
>>         """Generate the RFC 2822 email headers for this Change, a line at a time.
>>
>>         The output should not include the trailing blank line."""
>>
>>         raise NotImplementedError()
>>
>>     def generate_email_intro(self):
>>         """Generate the email intro for this Change, a line at a time.
>>
>>         The output will be used as the standard boilerplate at the top
>>         of the email body."""
>>
>>         raise NotImplementedError()
>>
>>     def generate_email_body(self):
>>         """Generate the main part of the email body, a line at a time.
>>
>>         The text in the body might be truncated after a specified
>>         number of lines (see multimailhook.emailmaxlines)."""
>>
>>         raise NotImplementedError()
>>
>>     def generate_email_footer(self):
>>         """Generate the footer of the email, a line at a time.
>>
>>         The footer is always included, irrespective of
>>         multimailhook.emailmaxlines."""
>>
>>         raise NotImplementedError()
> 
> Unsure what these are about.

These are basically just to allow code sharing across the various Change
classes.

>>     def generate_email(self, push, body_filter=None):
>>         """Generate an email describing this change.
>>
>>         Iterate over the lines (including the header lines) of an
>>         email describing this change.  If body_filter is not None,
>>         then use it to filter the lines that are intended for the
>>         email body."""
>>
>>         for line in self.generate_email_header():
>>             yield line
>>         yield '\n'
>>         for line in self.generate_email_intro():
>>             yield line
>>
>>         body = self.generate_email_body(push)
>>         if body_filter is not None:
> 
> Redundant "is not None".

This way of writing the test is robust against objects for which
bool(body_filter) might return False.

>>             body = body_filter(body)
>>         for line in body:
>>             yield line
>>
>>         for line in self.generate_email_footer():
>>             yield line
> 
> Nicely done with yield.
> 
>> class Revision(Change):
>>     """A Change consisting of a single git commit."""
>>
>>     def __init__(self, reference_change, rev, num, tot):
>>         Change.__init__(self, reference_change.environment)
> 
> super?

IMO, in Python 2.x, super() is really only useful in a class hierarchy
where multiple inheritance is going to be supported, like in the
Environment classes.  The problem is that even if you use super(), you
have to type the name of the containing class explicitly; e.g.,

    super(Revision, self).__init__(reference_change.environment)

It is even longer than the explicit reference to the parent class, and
though it doesn't break if another class is inserted into the
inheritance chain, it *does* break if the class itself is renamed.  So I
usually don't bother with super() unless I'm using multiple inheritance.

In Python 3, where super() doesn't require redundant arguments, it is
much less cumbersome to use.

> [...]
>>         # First line of commit message:
>>         try:
>>             oneline = read_git_output(
>>                 ['log', '--format=%s', '--no-walk', self.rev.sha1]
>>                 )
>>         except CommandError:
>>             oneline = self.rev.sha1
> 
> What does this mean?  When will you get a CommandError?

I can't think of a plausible reason that this command would fail.

>                                                          And how do
> you respond to it?

By using the commit's SHA-1 in place of its subject line.

>>         values['rev'] = self.rev.sha1
>>         values['rev_short'] = self.rev.short
>>         values['change_type'] = self.change_type
>>         values['refname'] = self.refname
>>         values['short_refname'] = self.reference_change.short_refname
>>         values['refname_type'] = self.reference_change.refname_type
>>         values['reply_to_msgid'] = self.reference_change.msgid
>>         values['num'] = self.num
>>         values['tot'] = self.tot
>>         values['recipients'] = self.recipients
>>         values['oneline'] = oneline
>>         values['author'] = self.author
> 
> Ugh.  Use
> 
>   { rev: self.rev.sha1,
>     rev_short: self.rev.short
>     ...
>   }
> 
> and merge it with the existing dictionary.

Yes, I could do that (though it needs quotes around the key strings).
Or the even more attractive

    values.update(
        rev=self.rev.sha1,
        rev_short=self.rev.short,
        ...
        )

I had the latter in an earlier version of the script, but I thought it
might be too unfamiliar for non-Python-experts.  I guess I'm using
pretty highfalutin Python anyway so this change wouldn't hurt.  What do
you think?

>                                             Unsure why you're building
> a dictionary in the first place.

To use in template interpolation and also the other reasons mentioned above.

> [...]
>>     @staticmethod
> 
> Unsure what such a huge static method is doing here, but we'll find
> out soon enough.
> 
>>     def create(environment, oldrev, newrev, refname):
>>         """Return a ReferenceChange object representing the change.
>>
>>         Return an object that represents the type of change that is being
>>         made. oldrev and newrev should be SHA1s or ZEROS."""
> 
> Like I said before, use the typesystem effectively: why is using a
> string with 40 zeros somehow better than None in your program _logic_?
> I can understand converting None to 40 zeros for display purposes.

The ZEROS come straight from the post-receive script input, and as soon
as they are wrapped in a GitObject they are turned into None.

>>         old = GitObject(oldrev)
>>         new = GitObject(newrev)
>>         rev = new or old
>>
>>         # The revision type tells us what type the commit is, combined with
>>         # the location of the ref we can decide between
>>         #  - working branch
>>         #  - tracking branch
>>         #  - unannotated tag
>>         #  - annotated tag
> 
> Could be simpler.

If you mean the distinction between four types of ref is
overcomplicated, this is something taken over from the old
post-receive-email script.  If you just mean that the code could be
simplified, then please make a suggestion.

> [...]
>>     def __init__(self, environment, refname, short_refname, old, new, rev):
>>         Change.__init__(self, environment)
>>         self.change_type = {
>>             (False, True) : 'create',
>>             (True, True) : 'update',
>>             (True, False) : 'delete',
>>             }[bool(old), bool(new)]
> 
> As a general principle, avoid casting: if new is a dictionary, what
> does bool(new) even mean?  You just have to trust types, and let go of
> that much safety.

old and new are not dictionaries, they are GitObject instances.  And
this is not casting, it is calling old.__nonzero__() and
new.__nonzero__() to see whether they are real objects vs. ZEROS and to
canonicalize their values so that they can be used as indexes for the
literal dictionary that decides what type of change is being described.

> [...]
>> class BranchChange(ReferenceChange):
>>     refname_type = 'branch'
> 
> Unsure what new information this conveys over the type.

It is made available for template interpolation.

> [...]
>>     def describe_tag(self, push):
>>         """Describe the new value of an annotated tag."""
>>
>>         # Use git for-each-ref to pull out the individual fields from
>>         # the tag
>>         [tagobject, tagtype, tagger, tagged] = read_git_lines(
>>             ['for-each-ref', '--format=%s' % (self.ANNOTATED_TAG_FORMAT,), self.refname],
>>             )
> 
> You could've saved yourself a lot of trouble by running one f-e-r on
> refs/tags and filtering that.  I don't know what you're gaining from
> this overzealous object-orientation.

It's only needed for the tags that have changed (which is probably zero
in most cases).

> [...]
>>         # Show the content of the tag message; this might contain a
>>         # change log or release notes so is worth displaying.
>>         yield LOGBEGIN
>>         contents = list(read_git_lines(['cat-file', 'tag', self.new.sha1], keepends=True))
> 
> You could've easily batched this.

I don't understand what you mean.

>>         contents = contents[contents.index('\n') + 1:]
>>         if contents and contents[-1][-1:] != '\n':
>>             contents.append('\n')
>>         for line in contents:
>>             yield line
>>
>>         if self.show_shortlog and tagtype == 'commit':
>>             # Only commit tags make sense to have rev-list operations
>>             # performed on them
>>             yield '\n'
>>             if prevtag:
>>                 # Show changes since the previous release
>>                 revlist = read_git_output(
>>                     ['rev-list', '--pretty=short', '%s..%s' % (prevtag, self.new,)],
>>                     keepends=True,
>>                     )
>>             else:
>>                 # No previous tag, show all the changes since time
>>                 # began
>>                 revlist = read_git_output(
>>                     ['rev-list', '--pretty=short', '%s' % (self.new,)],
>>                     keepends=True,
>>                     )
>>             for line in read_git_lines(['shortlog'], input=revlist, keepends=True):
>>                 yield line
>>
>>         yield LOGEND
>>         yield '\n'
> 
> Way too many git invocations, I think.

Luckily git is very fast :-)

I'm not to worried about performance here.  The script will typically
only be run on pushes, and most pushes affect only one or a few
references.  I don't think these few git invocations will be prohibitive.

>> class OtherReferenceChange(ReferenceChange):
>>     refname_type = 'reference'
>>
>>     def __init__(self, environment, refname, short_refname, old, new, rev):
>>         # We use the full refname as short_refname, because otherwise
>>         # the full name of the reference would not be obvious from the
>>         # text of the email.
>>         ReferenceChange.__init__(
>>             self, environment,
>>             refname=refname, short_refname=refname,
>>             old=old, new=new, rev=rev,
>>             )
>>         self.recipients = environment.get_refchange_recipients(self)
> 
> What is the point of this?  Why not just use ReferenceChange directly?

Maybe you missed "short_refname=refname" (one of the arguments is not
being passed through 1:1).  The reason is explained in the comment.

>> class Mailer(object):
>>     """An object that can send emails."""
>>
>>     def send(self, lines, to_addrs):
>>         """Send an email consisting of lines.
>>
>>         lines must be an iterable over the lines constituting the
>>         header and body of the email.  to_addrs is a list of recipient
>>         addresses (can be needed even if lines already contains a
>>         "To:" field).  It can be either a string (comma-separated list
>>         of email addresses) or a Python list of individual email
>>         addresses.
>>
>>         """
>>
>>         raise NotImplementedError()
> 
> Abstract base class (abc)?  Or do you want to support Python <2.6?

Yes, AFAIK the script works with any Python >= 2.4.

>> class SendMailer(Mailer):
>>     """Send emails using '/usr/sbin/sendmail -t'."""
>>
>>     def __init__(self, command=None, envelopesender=None):
>>         """Construct a SendMailer instance.
>>
>>         command should be the command and arguments used to invoke
>>         sendmail, as a list of strings.  If an envelopesender is
>>         provided, it will also be passed to the command, via '-f
>>         envelopesender'."""
>>
>>         if command:
>>             self.command = command[:]
>>         else:
>>             self.command = ['/usr/sbin/sendmail', '-t']
> 
> If you want to DWIM when the configuration variable is missing, do it
> fully using a list of good candidates like /usr/lib/sendmail,
> /usr/sbin/sendmail, /usr/ucblib/sendmail, /usr/bin/msmtp.

OK, I just added /usr/sbin/sendmail and /usr/lib/sendmail, which are the
paths checked by "git send-mail".

>                                                            Also, what
> happened to our faithful 'git send-email' Perl script?  Isn't that
> most likely to be installed?

We could use "git send-email" to generate and send the revision emails,
but then we would lose most control over the contents of the emails.

>>         if envelopesender:
>>             self.command.extend(['-f', envelopesender])
>>
>>     def send(self, lines, to_addrs):
>>         try:
>>             p = subprocess.Popen(self.command, stdin=subprocess.PIPE)
>>         except OSError, e:
>>             sys.stderr.write(
>>                 '*** Cannot execute command: %s\n' % ' '.join(self.command)
>>                 + '*** %s\n' % str(e)
>>                 + '*** Try setting multimailhook.mailer to "smtp"\n'
>>                 '*** to send emails without using the sendmail command.\n'
>>                 )
>>             sys.exit(1)
> 
> Why do you need to concatenate strings using +?  This can take a list of strings, no?

sys.stderr.write() can only take a single string argument.  You might
have seen it called like this:

    sys.stderr.write(
        'foo\n'
        'bar\n'
        )

This is using the Python compiler's feature that literal strings can be
appended to each other by juxtaposition (notice there are no commas).
But this only works for literal strings, not for string expressions.

> [...]
>>     def __del__(self):
>>         self.smtp.quit()
> 
> So you close the connection when the object is destroyed by the GC.

Yes, where here (since we are talking about CPython) reference counting
is used and objects are deleted as soon as the reference count goes to
zero.  The point is to send all of the emails through one connection to
the SMTP server, which I think saves a lot of time.

> [...]
>> class OutputMailer(Mailer):
>>     """Write emails to an output stream, bracketed by lines of '=' characters.
>>
>>     This is intended for debugging purposes."""
>>
>>     SEPARATOR = '=' * 75 + '\n'
>>
>>     def __init__(self, f):
>>         self.f = f
>>
>>     def send(self, lines, to_addrs):
>>         self.f.write(self.SEPARATOR)
>>         self.f.writelines(lines)
>>         self.f.write(self.SEPARATOR)
> 
> Unsure what this is.

For testing and debugging (e.g., via the --stdout command-line option).

>> def get_git_dir():
>>     """Determine GIT_DIR.
>>
>>     Determine GIT_DIR either from the GIT_DIR environment variable or
>>     from the working directory, using Git's usual rules."""
>>
>>     try:
>>         return read_git_output(['rev-parse', '--git-dir'])
>>     except CommandError:
>>         sys.stderr.write('fatal: git_multimail: not in a git working copy\n')
>>         sys.exit(1)
> 
> Why do you need a working copy?  Will a bare repository not suffice?

Yes, a bare repo definitely suffices.  I think the error message is just
misleading, correct?  Will fix.

>> class Environment(object):
> 
> New-style class.  I wonder why you suddenly switched.

?  All of the classes are new-style classes.

> [...]
>> class ConfigEnvironmentMixin(Environment):
>>     """A mixin that sets self.config to its constructor's config argument.
>>
>>     This class's constructor consumes the "config" argument.
>>
>>     Mixins that need to inspect the config should inherit from this
>>     class (1) to make sure that "config" is still in the constructor
>>     arguments with its own constructor runs and/or (2) to be sure that
>>     self.config is set after construction."""
>>
>>     def __init__(self, config, **kw):
>>         super(ConfigEnvironmentMixin, self).__init__(**kw)
>>         self.config = config
> 
> Overdoing the OO factories, much?

I went to a lot of trouble to make the Environment mixin classes
composable, because what I've learned from the feedback in the last
months is that everybody wants to do something different with this
script.  I tried out a few designs before I settled on this one.

> I'll skip a few boring factory classes.
> 
>> class GenericEnvironment(
>>     ProjectdescEnvironmentMixin,
>>     ConfigMaxlinesEnvironmentMixin,
>>     ConfigFilterLinesEnvironmentMixin,
>>     ConfigRecipientsEnvironmentMixin,
>>     PusherDomainEnvironmentMixin,
>>     ConfigOptionsEnvironmentMixin,
>>     GenericEnvironmentMixin,
>>     Environment,
>>     ):
>>     pass
> 
> Sigh.  I might as well be reading some Java now :/

No, Java doesn't allow multiple inheritance :-)

> Sorry, I'm exhausted.
> 
> Let's take a step back and look at what this gigantic script is doing.
> It uses the information from a push to string-interpolate a template
> and generate emails, right?  The rest of the script is about churning
> on the updated refs to prettify the emails.
> 
> From my quick reading, it seems to be unnecessarily complicated and
> inefficient.  Why are there so many factories, and why do you call out
> to git at every opportunity, instead of cleanly separating computation
> from rendering?

Regarding size: post-receive-email is 748 lines of shell script,
including comments and string literals.  The extent of its
configurability is approximately this block of code:

> projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
> # Check if the description is unchanged from it's default, and shorten it to
> # a more manageable length if it is
> if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
> then
> 	projectdesc="UNNAMED PROJECT"
> fi
> 
> recipients=$(git config hooks.mailinglist)
> announcerecipients=$(git config hooks.announcelist)
> envelopesender=$(git config hooks.envelopesender)
> emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
> custom_showrev=$(git config hooks.showrev)
> maxlines=$(git config hooks.emailmaxlines)
> diffopts=$(git config hooks.diffopts)
> : ${diffopts:="--stat --summary --find-copies-harder"}

The script has to be edited to make any non-trivial configuration change.

git_multimail.py is 2398 lines of Python script, including comments and
string literals.  The fraction of that code that is dedicated to
configurability is approximately 1000 lines.  Relative to
post-receive-email, it adds

* much more configurability, without the need to edit the script.

* optional separate emails for each commit

* non-buggy determination of which commits have been added by a
reference change, and distinction between commits that have been added
to a branch vs. commits that have been added altogether and between
commits that have been deleted from a branch vs. commits that have been
deleted altogether.

* migration code to migrate a post-receive-email configuration into a
git-multimail configuration (mostly via a supplemental script)

* support for gitolite environments

* support for sendmail vs. smtplib

* improved utf-8 correctness.

Regarding efficiency, I don't think it is a problem.  But patches or
concrete suggestions are certainly welcome.

Regarding separation of computation and rendering, yes, they could be
separated better.  (BTW, it would make the script even longer.)  The
rendering is already largely done via templates that can be changed from
outside of the script.  But I might work on separating them more
strictly so that some of the code could be reused, for example, to send
notifications via IRC or XMPP.

Thanks for all of your comments!  I hope I have addressed most of them
in this email and in the commits that I just pushed to GitHub.

Michael

[1] https://github.com/mhagger/git-multimail/pull/2
[2] http://www.python.org/dev/peps/pep-0394/

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
