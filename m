From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [RFC/PATCH 1/3] gitweb: make suspenders more useful
Date: Sun, 23 Aug 2009 18:39:14 -0400
Message-ID: <4A91C512.7000707@mailservices.uwaterloo.ca>
References: <4A91BA66.5050108@mailservices.uwaterloo.ca> <4A91BE50.7070103@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Rada <marada@uwaterloo.ca>, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Aug 24 00:40:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfLjG-00032p-3J
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 00:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbZHWWjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 18:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbZHWWjU
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 18:39:20 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:45299 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750851AbZHWWjT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 18:39:19 -0400
Received: from karakura.local (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7NMdEVJ013728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Aug 2009 18:39:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <4A91BE50.7070103@vilain.net>
X-UUID: 69156aeb-2ea8-4bd4-87e4-c392ae2bf38a
X-Miltered: at mailchk-m05 with ID 4A91C513.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Sun, 23 Aug 2009 18:39:19 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126893>

On 23/08/09 6:10 PM, Sam Vilain wrote:
> Mark Rada wrote:
>> Subject: [RFC/PATCH 1/3] gitweb: make suspenders more useful
> 
> Suspenders?  Really?
> 
> Sam
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Context:

On 21/08/09 5:43 PM, Junio C Hamano wrote:
> Mark A Rada <marada@uwaterloo.ca> writes:
> 
>> Unless I missed a case, the tests show that the extra condition check
>> that was added in the &git_snapshot routine is never actually executed,
>> because a disabled snapshot format is not added to @snapshot_fmts, which
>> is checked first.
>>
>> snippet:
>> 5178     } elsif (!grep($_ eq $format, @snapshot_fmts)) {
>> 5179         die_error(403, "Unsupported snapshot format");
>> 5180     } elsif ($known_snapshot_formats{$format}{'disabled'}) {
>> 5181         die_error(403, "Snapshot format not allowed");
>> 5182     }
>> 5183
> 
> True; filter_snapshot_fmts looks at 'disabled' first.
> 
> I do not mind keeping these two lines as belt-and-suspender, though.
> 


Yup...I couldn't think of an appropriate title and I expect this
patch to be edited (for another reason) or thrown out anyways.



-- 
Mark A Rada (ferrous26)
marada@uwaterloo.ca
