From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Problem packing repository
Date: Mon, 22 Jun 2009 09:53:28 -0500
Message-ID: <4A3F9AE8.30405@lwfinger.net>
References: <4A3EF989.4070101@lwfinger.net> <4A3F24F9.2060502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:53:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIktp-0005Cs-I3
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 16:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbZFVOxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 10:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbZFVOxW
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 10:53:22 -0400
Received: from fmailhost05.isp.att.net ([207.115.11.55]:51226 "EHLO
	fmailhost05.isp.att.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbZFVOxW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 10:53:22 -0400
DKIM-Signature: v=1; q=dns/txt; d=att.net; s=dkim01;
      i=larry.finger@att.net; a=rsa-sha256; c=relaxed/relaxed;
      t=1245682405; h=Content-Transfer-Encoding:Content-Type:
     In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:
     Message-ID; bh=SjbCiQPdZ1pOCG/zu1YnspNO44NGNCQ2udY6Q8qbqR0=; b=gtW
     kDO1xgkenrsj23PuUV4gPBE4q/7PHPgdNY2cQN1jpD2/7CLkgswiYeapHuzTrd1MVwr
     715fLJHB30fRkvEw==
Received: from [192.168.1.100] (cpe-65-28-94-183.kc.res.rr.com?[65.28.94.183])
          by worldnet.att.net (frfwmhc05) with ESMTP
          id <20090622145324H05004i92je>; Mon, 22 Jun 2009 14:53:25 +0000
X-Originating-IP: [65.28.94.183]
User-Agent: Thunderbird 2.0.0.19 (X11/20081227)
In-Reply-To: <4A3F24F9.2060502@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122043>

Johannes Sixt wrote:
> Larry Finger schrieb:
>> For the past 2 weeks, every pull from the mainline kernel repository
>> has included the following message about "Auto packing" that fails to
>> complete.
>>
>> git --version yields "git version 1.6.3.2.198.g6096d"
>>
>> ================================================
>>
>> Auto packing your repository for optimum performance. You may also
>> run "git gc" manually. See "git help gc" for more information.
>> usage: git-pack-objects [{ -q | --progress | --all-progress }]
>>         [--max-pack-size=N] [--local] [--incremental]
>>         [--window=N] [--window-memory=N] [--depth=N]
>>         [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]
>>         [--threads=N] [--non-empty] [--revs [--unpacked | --all]*]
>> [--reflog]
>>         [--stdout | base-name] [--include-tag]
>>         [--keep-unreachable | --unpack-unreachable]
>>         [<ref-list | <object-list]
>> error: failed to run repack
> 
> I'm pretty sure that you have inconsistent versions of git in your PATH.
> You can use GIT_TRACE=2 to debug this. I think that you should get the
> same error if you run 'git gc' manually.

Thanks. My initial git installation came from an openSUSE 11.1
package. I had then pulled the source, deleted the package, then built
and installed the new version. Unfortunately, not everything was
removed, but it is working now.

Larry
