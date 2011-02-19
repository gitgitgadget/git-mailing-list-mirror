From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: What's the definition of a valid Git symbolic reference?
Date: Sat, 19 Feb 2011 07:10:50 -0600
Organization: Digium, Inc.
Message-ID: <4D5FC15A.30309@digium.com>
References: <AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=d8xkw7@mail.gmail.com> <F624322D-359A-48ED-A241-622042F77CDA@sb.org> <AANLkTi=FKXqu_psoT+gvyq2c_o8Mej+DgpccecOpQd8H@mail.gmail.com> <4D5A0901.7080202@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Emeric Fermas <emeric.fermas@gmail.com>,
	Kevin Ballard <kevin@sb.org>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>, libgit2@librelist.com
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:11:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqmaX-0005yQ-AM
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab1BSNLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:11:00 -0500
Received: from mail.digium.com ([216.207.245.2]:60685 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab1BSNK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:10:59 -0500
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1PqmaK-0005Rp-No; Sat, 19 Feb 2011 07:10:52 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id AE831D82A1;
	Sat, 19 Feb 2011 07:10:52 -0600 (CST)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SVVhz+TBkidX; Sat, 19 Feb 2011 07:10:52 -0600 (CST)
Received: from [192.168.1.6] (173-24-207-63.client.mchsi.com [173.24.207.63])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 9DE54D82A0;
	Sat, 19 Feb 2011 07:10:51 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <4D5A0901.7080202@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167272>

On 02/14/2011 11:02 PM, Tomas Carnecky wrote:
> On 2/15/11 4:49 AM, Emeric Fermas wrote:
>> Another possibility would be that only git internal symbolic
>> references are allowed to live under the ".git" dir (HEAD, FETCH_HEAD,
>> ...) and that user defined symrefs should live under refs/. In this
>
> All refs should live under refs/ (except the special ones like HEAD
> etc). It's usually a mistake if someone manages to create one outside of
> refs/. The plumbing commands allow you to do that, but users usually
> shouldn't use those.

Being able to manually point HEAD at a ref is actually useful; when I've 
created repos that start out with a 'vendor branch', I want to do the 
initial import into a branch called 'upstream', not 'master'. Using 'git 
symbolic-ref HEAD refs/heads/upstream' in a brand-new repo allows that 
to happen, and works quite well.

Please don't take it away :-)

-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
