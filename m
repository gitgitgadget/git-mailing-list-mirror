From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] git reset --hard gives clean working tree
Date: Mon, 07 Mar 2016 09:58:22 +0100
Message-ID: <56DD42AE.2010200@web.de>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>	<1455207366-24892-1-git-send-email-tboegi@web.de>	<xmqqy4arw089.fsf@gitster.mtv.corp.google.com>	<56DA896A.3050201@web.de>	<xmqqtwklwdrh.fsf@gitster.mtv.corp.google.com>	<56DA986B.6040003@web.de>	<xmqqr3fotyhu.fsf@gitster.mtv.corp.google.com>	<xmqqpov6puv7.fsf@gitster.mtv.corp.google.com> <xmqqlh5upt6q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?windows-1252?Q?Torsten_B=F6ge?= =?windows-1252?Q?rshausen?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 07 09:58:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acr05-0001Ek-Q1
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 09:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbcCGI6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 03:58:40 -0500
Received: from mout.web.de ([212.227.17.11]:64475 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbcCGI6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 03:58:33 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M4I2R-1ZmOpf1JIZ-00rqST; Mon, 07 Mar 2016 09:58:24
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqqlh5upt6q.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:hFHU6BuXvOMmouCsq5GULU2eCHVoFiiRbmZzCyEn1fZxzLSs5t8
 Ekzjsd2VQfjJ7AhiJcFB+C194DeS6gD9eOmPDG+GPqjNhSmwVwaT2irGsvBS6pkhB18idnc
 2mVBvdvj6MEWwrqVRgZ5AVMTxTc/kAr5beJy0JJSQABLxvWoGEuu4E+RSS27Bp0bzZguIx7
 7dS2y0BO6ByWHUuRDsS+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w5ekHm8BlOk=:IVgbxsaD2qNhEsvqRQ6+5r
 sml24fsREWFWID1znTZx0kOK8vPLqsg/OXKrzHlwPjPfQPI2RLvBPw+sdkbk2bREGrhWbITNF
 qCjaJlLx6s8CyGYdi85YILiENffP/74I3xpCQd1PmhXefOwognCL1uPpC4nXDMmTndQLb8Yo5
 ufb6/Skr2pSKVTVA/bSzYRGIiara2/n3LlxnzRThMKmX79WKn4fKG4JACyFojwhB4ErZ2hY+8
 eIgDrBE0fhG4J8hui1BfqgVw4oCvFvbTclzP29KqX+FK7CqcHYpnqVNF5lZQzEqy0OEN0QvNK
 j3K+EeYjWZD840D6kwd1Ow81JFj/EtZ2rEmz5PNqhpx1bdLdbtJyhYKsWL4NTwuWUsfOR8+nt
 GfG/VHiNKnkXEDHMMgKpYbzkr3xJPoe+3Wvh3g2tTc0/RWhcUWCkIZSyruF34GBlCuohM49sL
 /XnKmcbIBUdLAjsWcOmOmTPLZC/GW2TCESdsi82rqIXyFKzhdp+4XUy1OYiUfM0KuW11A/fQJ
 6mR/BRDMQSJQUzr4MDANQfa6XcaP6XN7lUem7GocO3caQ70V7fxLSIEAwhflNNy57F5IG/0Ch
 FU3mjTQKDHn2CWX7YYHzRoZkWHu55rY8cbE+n5/GvLGEwIp402Wmup5tKifQDrmtS9/SZv41S
 6uA7LQEVGgwOEzVJzi8Qyj3MYN+tgsym84clGyaf45H46d3j6/wiPZlPWZlkiMa24Y2aI5Aw7
 hE0NbJe9D8u6WsgVa9Ifk84K9e6L3AM5a4gbEaYArK8jzJiiw5Jk9eq4LoktDDgHtMdu7PAe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288386>

On 03/07/2016 09:51 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Perhaps we can introduce a new function can_clobber() that has the
>> same function signature as ce_uptodate() and update the callers in
>> apply and unpack-trees (there may be others) to call it instead when
>> they want to see if they can clobber the working tree file that
>> corresponds to the cache entry.
> By the way, I do not want see ie_match_stat() modified to work like
> the can_clobber() I outlined in the previous message, which in turn
> means that immediately after "git reset --hard" or "git checkout"
> when your convert_to_git() and convert_to_working_tree() do not
> roundtrip, you _must_ see differences in "git diff".
>
> This is for (at least) two reasons.
>
>   * "git diff" (compare between the index and the working tree) is
>     meant as a preview of how the indexed contents will be modified
>     if you did "git add" with what you currently have in your working
>     tree at the path.  In a "conversions do not roundtrip" situation,
>     your "git add" will be modifying the contents in the index, so we
>     should actively be showing what modification we will be making.
>
>     One way of "fixing" the situation without changing either the
>     working tree contents or the indexed contents is to fix your
>     convert-to-git settings to make the conversions round-trip, and
>     then you would stop seeing the changes you would make when you do
>     "git add".  Not showing any diff when can_clobber() is true but
>     ce_uptodate() is false would make "git diff" less useful when the
>     user makes this correction.
>
>   * "git add" of a path can legitimately optimize itself by not
>     adding a path that is ce_uptodate().  Mixing ie_match_stat()
>     with can_clobber() logic would mark such a "conversions do not
>     roundtrip" path as ce_uptodate(), and prevent the user from
>     "fixing" the incorrect index entry by running "git add".
>
Thanks.
OK about "git add" and "git diff".
The major question, at least on my side, is where to hook in 
"can_clobber()" ?
