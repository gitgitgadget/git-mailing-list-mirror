From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Mon, 24 Mar 2014 13:22:45 +0100
Message-ID: <53302395.6090207@alum.mit.edu>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com> <loom.20140318T124348-742@post.gmane.org> <lg9l22$qto$1@ger.gmane.org> <CAPig+cQLACyFwVypi08ZGQ14mpc0zt0fRRNhPzswRjsTaFQz2A@mail.gmail.com> <lgekju$u6t$1@ger.gmane.org> <CAPig+cRv-WvoMVY0PDgtLawywe0QfpX8oPetzNwD-9Jq6BOjyw@mail.gmail.com> <xmqqr45vv5q8.fsf@gitster.dls.corp.google.com> <532CAB89.7030303@alum.mit.edu> <lgomc3$rh0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aleksey Mokhovikov <moxobukob@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 13:22:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS3u2-0002A1-Gc
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 13:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbaCXMWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 08:22:50 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56470 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752923AbaCXMWt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 08:22:49 -0400
X-AuditID: 12074414-f79d96d000002d2b-12-53302397646f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 15.D0.11563.79320335; Mon, 24 Mar 2014 08:22:47 -0400 (EDT)
Received: from [192.168.69.148] (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OCMk3t027376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 08:22:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <lgomc3$rh0$1@ger.gmane.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqDtd2SDYYPk/G4uuK91MFpdXzWRz
	YPLYOesuu8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bmdiy0KlvFXXJu/kbWBcRlPFyMHh4SAicTe
	d0JdjJxAppjEhXvr2boYuTiEBC4zSrTPeMQK4ZxnkmjZc4cNpIpXQFvi06lWRhCbRUBV4vHv
	36wgNpuArsSinmYmEFtUIFhi9eUHLBD1ghInZz4Bs0UEdCR2HGtiB1nMLCAu0f8PLCwsUC1x
	Ytd8qF1zmSXebJkHNpNTQFOi414nM8Sh4hI9jUEgYWagMe/6HjBD2PIS29/OYZ7AKDgLybZZ
	SMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMkeEV2MB45KXeI
	UYCDUYmHd0aXfrAQa2JZcWXuIUZJDiYlUV4LBYNgIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
	p8SBcrwpiZVVqUX5MClpDhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErxzlIAaBYtS01Mr
	0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kHRG18MjF+QFA/Q3gUg7bzFBYm5QFGI1lOMuhwb
	tq1pZBJiycvPS5US5xUFKRIAKcoozYNbAUtVrxjFgT4W5s0FqeIBpjm4Sa+AljABLQlv0gNZ
	UpKIkJJqYPTo22U427G6oSw+2vnZtfOSjXEXDsgEzjoqZfmsNujEess26WP3b27qrFi37cmN
	LN57Ph/blNd+Yrr0/M7LZW9Y9rx8lbSUpSZsgWnEs33uhdu6V8qGR2o7Zy+68ahy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244820>

On 03/24/2014 08:28 AM, Aleksey Mokhovikov wrote:
> On 03/22/2014 04:13 AM, Michael Haggerty wrote:
>> My expectation when I invented that microproject was that converting the
>> code to be table-driven would be judged *not* to be an improvement.  I
>> was hoping that a student would say "the 'if' statement is OK, but let's
>> delete this ridiculous unreachable else branch".  Possibly they would
>> convert the "if" chain into nested "if"s, which I think would allow some
>> code consolidation in one of the branches.
>>
>> But not a single student agreed with me, so I must be in a minority of
>> one (which, unfortunately, is the definition of lunacy).
>>
>> The multidimensional array lookup table is not so terrible, but I
>> personally still prefer the "if".
> 
> That was expectable. But the main goal for me was to participate in git
> development process, to become familiar with it.
> It looks hard to participate when not proposing a patch.
> I thought about make a small change in if chain, but it looked to minor
> to feel whole development process.
> I've used git features for formatting and sending a patch to mailing list.
> I've met the GNU gettext restrictions when proposed a first patch.
> Proposed another patch and tried to show Pros and Cons.
> It didn't look like applying a patch to git master branch was the main goal.
> As for me that was quite interesting and useful.

Sorry if there was a misunderstanding.  I didn't mean to criticize you
and certainly not to single you out among the many students who went for
a table-driven solution.  I was rather replying to Junio's general
comment, that maybe changing the code to be table-driven wasn't such a
good idea.  These things are always a matter a taste, and sometimes hard
to predict before one has tried writing the code a couple of different ways.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
