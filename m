From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Sun, 28 Jun 2015 07:51:17 +0200
Message-ID: <558F8B55.1070708@alum.mit.edu>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com> <1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr> <xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com> <CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com> <CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 07:51:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z95VI-0006U7-Q5
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 07:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbbF1Fvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 01:51:35 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42092 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751741AbbF1Fve (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jun 2015 01:51:34 -0400
X-AuditID: 12074414-f794f6d000007852-59-558f8b584ae7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F6.F9.30802.85B8F855; Sun, 28 Jun 2015 01:51:20 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2F50.dip0.t-ipconnect.de [93.219.47.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5S5pHbr005109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 28 Jun 2015 01:51:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqBvR3R9qcOewpsXMmdYWt2e2MFt0
	XelmsmjovcJs8X/HAhaLJa8fMTuweVxtDvDYOesuu8exY63MHhcvKXt83iQXwBrFbZOUWFIW
	nJmep2+XwJ3x6vpV1oIzPBWdbdOYGxgbuLoYOTkkBEwkDm87xgRhi0lcuLeerYuRi0NI4DKj
	xM1H21ghnHNMEsfvr2MBqeIV0Ja4OrGPHcRmEVCV2LJwLpjNJqArsainGWgSB4eoQJDE65e5
	EOWCEidnPgFrFRGIk/jx8yLYAmaB/YwSO558BNssLOAkMeXTdmaIZWuYJK5OWM0MkuAUCJR4
	8e4R2AJmAXWJP/MuMUPY8hLNW2czT2AUmIVkySwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxb
	nJyYl5dapGuhl5tZopeaUrqJERLsIjsYj5yUO8QowMGoxMProdsfKsSaWFZcmXuIUZKDSUmU
	t9UBKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd2sCUI43JbGyKrUoHyYlzcGiJM77bbG6n5BA
	emJJanZqakFqEUxWhoNDSYL3fydQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwo
	WuOLgfEKkuIB2jsFpJ23uCAxFygK0XqKUVFKnPc0SEIAJJFRmgc3FpbCXjGKA30pzOvTBVTF
	A0x/cN2vgAYzAQ1e5d0HMrgkESEl1cCYzizDMHNOI9+1Ok8hU7Zdm7q2va2SvBq++POUWym+
	MfIu+endTzQMnx8OPs2Z93Txv7udq4ozD+ZXRUonH3Z95jP/Kd+EBiZV9YPaWaFC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272867>

On 06/27/2015 06:25 AM, Junio C Hamano wrote:
> On Fri, Jun 26, 2015 at 9:10 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> If we don't want to support positional arguments, then I would suggest
>> supporting first the following instead:
>>
>>          git bisect terms --name-good=fast --name-bad=slow
>>          git bisect terms --name-bad=slow --name-good=fast
>>
>> This would make the interface consistent with the code.
> 
> Which somewhat defeats the point of introducing "old" and "new", though.
> The "terms" support is for people who feel that good/bad would be too confusing
> for the particular bisect session (e.g. because they are hunting for a fix).
> 
>>> We may want to start supporting
>>>
>>>         git bisect start --new=master --old=maint
>>
>> Maybe we could also support:
>>
>> git bisect start --name-good=fast --name-bad=slow --fast=maint --slow=master
> 
> The same comment for the token after --name-, but allowing the terms to be set
> at "start" could be a type-saver.  With need for added "--name-"
> prefix (worse, twice),
> I am not sure if it would be seen as a useful type-saver, though.

I would like to remind everybody of my old claim that it would be
possible to teach `git bisect` to infer by itself which term means
"older" and which term means "newer":

    http://article.gmane.org/gmane.comp.version-control.git/244036

I think that making `bisect` smarter could make the UI simpler, though
admittedly it would be more work than the current proposal.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
