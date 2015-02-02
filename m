From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/3] CodingGuidelines: describe naming rules for configuration
 variables
Date: Mon, 02 Feb 2015 07:47:27 +0100
Message-ID: <54CF1D7F.6050903@alum.mit.edu>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>	<1422484393-4414-1-git-send-email-gitster@pobox.com>	<1422484393-4414-4-git-send-email-gitster@pobox.com>	<54CDB5C6.3020702@alum.mit.edu> <xmqq1tm99yhx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 07:54:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIAuI-0003Cp-BJ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 07:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbbBBGyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 01:54:46 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63179 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932513AbbBBGyp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 01:54:45 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Feb 2015 01:54:45 EST
X-AuditID: 1207440e-f79bc6d000000c43-2e-54cf1d831bde
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E1.C9.03139.38D1FC45; Mon,  2 Feb 2015 01:47:31 -0500 (EST)
Received: from [192.168.69.130] (p4FC96EED.dip0.t-ipconnect.de [79.201.110.237])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t126lSi3032190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 2 Feb 2015 01:47:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <xmqq1tm99yhx.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqNssez7E4Ot5IYuuK91MFg29V5gt
	+pd3sVn8aOlhdmDx+PAxzuNZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M443r6HueCZ
	XsWFnz4NjD9Vuhg5OSQETCSWvJjICGGLSVy4t56ti5GLQ0jgMqNE54+r7BDOeSaJy8/esoNU
	8QpoS3yb8JEJxGYRUJU407gErJtNQFdiUU8zWFxUIEjiSstmZoh6QYmTM5+wgNgiAo4SJx5c
	ZwWxmQU8JeZvWMYGYgsLxElse/cCavNnRomm9VfBmjkFrCX2nrrBBtGgJ7Hj+i+oZnmJ5q2z
	mScwCsxCsmMWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11svNLNFLTSndxAgJ
	Z74djO3rZQ4xCnAwKvHwTvh4LkSINbGsuDL3EKMkB5OSKG/HH6AQX1J+SmVGYnFGfFFpTmrx
	IUYJDmYlEV5hkHLelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvtsz5
	ECHBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKzGFwOjFSTFA7TXHKSdt7ggMRco
	CtF6ilFRSpw3DiQhAJLIKM2DGwtLUq8YxYG+FOatA6niASY4uO5XQIOZgAYvm3QGZHBJIkJK
	qoGRY/ttju/z7nztlhcu63RVKGh0udlUO0neOrkucaFN9crdCmveXk/8mNr38MgWW5nb0/dv
	7ZE408rAlmO1Zm9V/izLZBtuVevNPwVd4qt/b2guL1/2esKOZ+FvvdfaOvJvtvpo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263252>

Junio,

Thanks for your thoughtful response.

On 02/01/2015 09:18 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 01/28/2015 11:33 PM, Junio C Hamano wrote:
>>> +   When choosing the variable namespace, do not use variable name for
>>> +   specifying possibly unbounded set of things, most notably anything
>>> +   an end user can freely come up with (e.g. branch names), but also
>>> +   large fixed set defined by the system that can grow over time
>>> +   (e.g. what kind of common whitespace problems to notice).
>>
>> I think we can all agree with this rule for "anything an end user can
>> freely come up with". Such sets are truly unbounded.
>>
>> But what is the justification for applying it to "large fixed set
>> defined by the system that can grow over time"?
> [...]
> 
> I can see it argued that for things that are completely independent
> (e.g. the consequence of setting fsck.badDate can never be affected
> by how fsck.missingTagger is configured), separate configuration
> variables may not be wrong per-se, but I can see that a set of knobs
> that would have been originally independent, as the operation grow
> richer, gain more semantics to make them related, and at that point,
> I doubt "they are internally independent; expose them as independent
> to the end users" argument would hold water that well.
> 
> A good example is "core.whitespace", where you would have started
> with a simple set of booleans ("blank-at-eol" and "space-before-tab"
> are conceptually independent and will stay to be), but once you
> start supporting "indent-with-non-tab" and "tab-in-indent" you
> cannot pretend that they are independent.
> 
> And that is the "existing practice" I primarily had in mind.  We
> didn't do
> 
> 	whitespace.tabInIndent = true
>         whitespace.indentWithNonTab = true
> 
> to pretend they are independent and still internally having to make
> sure the consistency of the setting.  We structured the syntax for
> ease of the end user (not scripter) to shorter
> 
> 	core.whitespace = tab-in-indent,indent-with-non-tab
> 
> as we need the consistency thing either way (and it is easier to see
> the consistency mistakes when they appear next to each other).
> 
> And I am happy that we chose wisely in an early version that didn't
> use one-variable-per-knob but used list-of-features-as-value instead.

You make an interesting point: values that start as a list of
independent booleans can grow dependencies over time.

In retrospect, ISTM that a better interface for the indentation-related
"whitespace" settings would have been something like

* "whitespace.indent" -- a single value chosen from "tabs-only |
spaces-only | tabs-when-possible | anything"
* "whitespace.tabwidth" -- an integer value

This would have made the mutual-exclusivity of those choices manifest in
the style of configuration rather than hoping that the user notices that
his settings contradict each other.

Let's dig into this example some more by imagining some other
hypothetical future extensions. Suppose we wanted to support different
whitespace rules for different types of files [1]. For example, I might
never want to forbid "cr-at-eol" everywhere, and might usually like to
uses spaces for my indentation, but for Makefiles need to indent using
tabs. The "type 2" syntax, I think, is pretty straightforward:

    [whitespace]
            cr-at-eol = error
            indent = spaces-only

    [whitespace "makefile"]
            indent = tabs-only

Our usual rules, "last setting wins" and "foo.*.bar, if present, takes
precedence overrides foo.bar", make it pretty clear how the above should
be interpreted.

What would be the "type 1" syntax for this? Would "cr-at-eol" be
inherited from "core.whitespace" to "core.makefile.whitespace"? If not,
then I have to repeat "cr-at-eol":

    [core]
            whitespace = cr-at-eol tab-in-indent
    [core "makefile"]
            whitespace = cr-at-eol indent-with-non-tab

[2]. If values are inherited, then do I also have to countermand
"tab-in-indent" in the "makefile" rule?

    [core]
            whitespace = cr-at-eol tab-in-indent
    [core "makefile"]
            whitespace = indent-with-non-tab -tab-in-indent

Or does "indent-with-non-tab" automatically supersede "tab-in-indent",
according to last-setting-wins (an interpretation that starts requiring
the config parser to have domain-specific knowledge)?:

    [core]
            whitespace = cr-at-eol tab-in-indent
    [core "makefile"]
            whitespace = indent-with-non-tab

But if that is the case, which setting wins in this scenario?:

    [core]
            whitespace = cr-at-eol tab-in-indent
    [core "makefile"]
            whitespace = indent-with-non-tab
    # In another config file maybe:
    [core]
            whitespace = space-before-tab

Does "core.whitespace = space-before-tab" supersede
"core.makefile.whitespace = indent-with-non-tab" here?

No matter which of the "type 1" variants we choose, we would have to
invent new rules for users and config parsers to learn, and some of
those rules would require domain-specific knowledge to interpret.
Whereas the "type 2" style is pretty straightforward and leans only on
existing conventions.

> [...]

Michael

[1] I'm not claiming that this specific extension makes sense. It might
make more sense to configure the whitespace rules one-by-one using
gitattributes. But I think it is nevertheless a typical way that
features are extended and therefore an interesting gedankenexperiment.

[2] For the purposes of this discussion, let's ignore the fact that
there is no precedent for a three-level "core" setting like
"core.makefile.whitespace". It could just as easily be spelled
"whitespace.makefile.check" or something in the "type 1" syntax.

-- 
Michael Haggerty
mhagger@alum.mit.edu
