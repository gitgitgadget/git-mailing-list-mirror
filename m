From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Thu, 04 Oct 2012 11:34:47 +0200
Message-ID: <506D5837.6020708@alum.mit.edu>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org> <CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com> <7vbogj5sji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:13:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtVj-0001w8-Ac
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843Ab2JDJew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 05:34:52 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:56214 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755293Ab2JDJeu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 05:34:50 -0400
X-AuditID: 12074411-b7fa36d0000008cc-8e-506d5839d5e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 21.15.02252.9385D605; Thu,  4 Oct 2012 05:34:49 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q949YlWl002818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Oct 2012 05:34:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vbogj5sji.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqGsZkRtg8OanuUXXlW4mi4beK8wW
	3VPeMjowe+ycdZfd4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDN+rPzBXrBDuaKn8RhLA2OP
	dBcjJ4eEgInEtcl32CFsMYkL99azdTFycQgJXGaU2DbpNCtIQkjgGJNEw9fwLkYODl4BbYnZ
	vx1BTBYBVYm/z7RBKtgEdCUW9TQzgdiiAiESMy5PZgaxeQUEJU7OfMICYosIqElMbDsEZjML
	OEqcWrYZrF5YwE7iy4lXLBBrlzBKvLz9E6yZU8BMou/DN3aIBh2Jd30PmCFseYntb+cwT2AU
	mIVkxywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERK4gjsY
	Z5yUO8QowMGoxMOr3ZITIMSaWFZcmXuIUZKDSUmUVzg8N0CILyk/pTIjsTgjvqg0J7X4EKME
	B7OSCO9EH6Acb0piZVVqUT5MSpqDRUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mCNxhkqGBR
	anpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoTuOLgZEKkuIB2qsC0s5bXJCYCxSFaD3F
	aMlx9M3ch4wcJ/6ByI+N8x4yCrHk5eelSonzaoI0CIA0ZJTmwa2Dpa9XjOJA3wvzuoJU8QBT
	H9zUV0ALmYAWrtDNAllYkoiQkmpgnH6b42RjFstfxd8TCy4/nS/brb58vVW56flzkY8n79m+
	vGKZt971dbWtXbysQcdLYk5a1Hi1R6zy9F/7r3Rq2sbTKwuV2yzWRRen96rlXuAO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206980>

On 10/03/2012 08:17 PM, Junio C Hamano wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>> There's an interesting case: "**foo". According to our rules, that
>> pattern does not contain slashes therefore is basename match. But some
>> might find that confusing because "**" can match slashes,...
> 
> By "our rules", if you mean "if a pattern has slash, it is anchored",
> that obviously need to be updated with this series, if "**" is meant
> to match multiple hierarchies.
>> I think the latter makes more sense. When users put "**" they expect
>> to match some slashes. But that may call for a refactoring in
>> path_matches() in attr.c. Putting strstr(pattern, "**") in that
>> matching function may increase overhead unnecessarily.
>>
>> The third option is just die() and let users decide either "*foo",
>> "**/foo" or "/**foo", never "**foo".
> 
> For the double-star at the beginning, you should just turn it into "**/"
> if it is not followed by a slash internally, I think.
> 
> What is the semantics of ** in the first place?  Is it described to
> a reasonable level of detail in the documentation updates?  For
> example does "**foo" match "afoo", "a/b/foo", "a/bfoo", "a/foo/b",
> "a/bfoo/c"?  Does "x**y" match "xy", "xay", "xa/by", "x/a/y"?
> 
> I am guessing that the only sensible definition is that "**"
> requires anything that comes before it (if exists) is at a proper
> hierarchy boundary, and anything matches it is also at a proper
> hierarchy boundary, so "x**y" matches "x/a/y" and not "xy", "xay",
> nor "xa/by" in the above example.  If "x**y" can match "xy" or "xay"
> (or "**foo" can match "afoo"), it would be unreasonable to say it
> implies the pattern is anchored at any level, no?

Given that there is no obvious interpretation for what a construct like
"x**y" would mean, and many plausible guesses (most of which sound
rather useless), I suggest that we forbid it.  This will make the
feature easier to explain and make .gitignore files that use it easier
to understand.

I think that 98% of the usefulness of "**" would be in constructs where
it replaces a proper part of the pathname, like "**/SOMETHING" or
"SOMETHING/**/SOMETHING"; in other words, where its use matches the
regexp "(^|/)\*\*/".  In these constructs the only ambiguity is whether
"**/" matches regexp

    "([^/]+/)+"

or

    "([^/]+/)*"

(e.g., whether "foo/**/bar" matches "foo/bar").  I personally prefer the
second, because the first behavior can be had using the second
interpretation by using "SOMETHING/*/**/SOMETHING", whereas the second
behavior cannot be implemented in terms of the first in a single line of
the .gitignore file.

Optionally, one might also like to support "SOMETHING/**" or "**" alone
in the obvious ways.

As for the implementation, it is quite easy to textually convert a glob
pattern, including "**" parts, into a regexp.  I happen to have written
some Python code that does this for another project (see below).  An
obvious optimization would be to read any literal parts of the path off
the beginning of the glob pattern and only use regexps for the tail
part.  Would a regexp-based implementation be too slow?

Michael

_filename_char_pattern = r'[^/]'
_glob_patterns = [
    ('?', _filename_char_pattern),
    ('/**', r'(/.+)?'),
    ('**/', r'(.+/)?'),
    ('*', _filename_char_pattern + r'*'),
    ]


def glob_to_regexp(pattern):
    pattern = os.path.normpath(pattern) # remove trivial redundancies

    if pattern == '**':
        # This case has to be handled separately because it doesn't
        # involve a '/' character adjacent to the '**' pattern.  (Such
        # slashes otherwise have to be considered part of the pattern
        # to handle the matching of zero path components.)
        return re.compile(
            r'^' + _filename_char_pattern + r'(.+' +
_filename_char_pattern + r')?$'
            )

    regexp = [r'^']
    i = 0
    while i < len(pattern):
        for (s, r) in _glob_patterns:
            if pattern.startswith(s, i):
                regexp.append(r)
                i += len(s)
                break
        else:
            # AFAIK it's a normal character.  Escape it and add it to
            # pattern.
            regexp.append(re.escape(pattern[i]))
            i += 1

    regexp.append(r'$')

    return re.compile(''.join(regexp))




-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
