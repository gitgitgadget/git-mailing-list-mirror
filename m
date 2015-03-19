From: Bharat Suvarna <bharat.bs84@icloud.com>
Subject: Re: Git with Lader logic
Date: Thu, 19 Mar 2015 07:14:52 +0000
Message-ID: <E914A3D7-1BF0-4962-8B4E-F0E19477926B@icloud.com>
References: <5F9B9EBF-CD4D-42A8-8A0C-9806702231A1@icloud.com>
 <00bd01d061b5$331874c0$99495e40$@nexbridge.com>
 <CAEtYS8R6xz3vMD72h_j0R6W=FRfY7SjMi-q9z+qfKhqoq5ExCg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>,
	Git List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 08:15:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYUfz-0001G7-Nz
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 08:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbbCSHP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 03:15:26 -0400
Received: from st11p01mm-asmtpout002.mac.com ([17.172.204.237]:42340 "EHLO
	st11p01mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754709AbbCSHPX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 03:15:23 -0400
Received: from [192.168.1.123]
 (host31-52-159-201.range31-52.btcentralplus.com [31.52.159.201])
 by st11p01mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7.0.5.35.0 64bit (built Dec  4 2014))
 with ESMTPSA id <0NLG001IU6STS040@st11p01mm-asmtp002.mac.com> for
 git@vger.kernel.org; Thu, 19 Mar 2015 07:14:56 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.13.68,1.0.33,0.0.0000
 definitions=2015-03-19_02:2015-03-19,2015-03-19,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1412110000 definitions=main-1503190072
X-Mailer: iPhone Mail (12D508)
In-reply-to: <CAEtYS8R6xz3vMD72h_j0R6W=FRfY7SjMi-q9z+qfKhqoq5ExCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265793>

Thanks all .. I will have a look. But could I just set this up on my laptop and checking this works on system first before installing one of Git on server

Sent from my iPhone

> On 18 Mar 2015, at 22:28, Doug Kelly <dougk.ff7@gmail.com> wrote:
> 
> On Wed, Mar 18, 2015 at 2:53 PM, Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
>> On March 17, 2015 7:34 PM, Bharat Suvarna wrote:
>>> I am trying to find a way of using version control on PLC programmers like
>> Allen
>>> Bradley PLC. I can't find a way of this.
>>> 
>>> Could you please give me an idea if it will work with Plc programs. Which
>> are
>>> basically Ladder logic.
>> 
>> Many PLC programs either store their project code in XML, L5K or L5X (for
>> example), TXT, CSV, or some other text format or can import and export to
>> text forms. If you have a directory structure that represents your project,
>> and the file formats have reasonable line separators so that diffs can be
>> done easily, git very likely would work out for you. You do not have to have
>> the local .git repository in the same directory as your working area if your
>> tool has issues with that or .gitignore. You may want to use a GUI client to
>> manage your local repository and handle the commit/push/pull/merge/rebase
>> functions as I expect whatever PLC system you are using does not have git
>> built-in.
>> 
>> To store binary PLC data natively, which some tools use, I expect that those
>> who are better at git-conjuring than I, could provide guidance on how to
>> automate binary diffs for your tool's particular file format.
> 
> The one thing I find interesting about RSLogix in general (caveat: I
> only have very limited experience with RSLogix 500 / 5000; if I do
> anything nowadays, it's in the micro series using RSLogix Micro
> Starter Lite)... they do have some limited notion of version control
> inside the application itself, though it seems rudimentary to me.
> This could prove to be helpful or extremely annoying, since even when
> I connect to a PLC and go online, just to reset the RTC, it still
> prompts me to save again (even though nothing changed, other than the
> processor state).
> 
> You may also find this link on stackexchange helpful:
> http://programmers.stackexchange.com/questions/102487/are-there-realistic-useful-solutions-for-source-control-for-ladder-logic-program
> 
> As Randall noted, L5K is just text, and RSLogix 5000 uses it,
> according to this post.  It may work okay.
> 
> --Doug
