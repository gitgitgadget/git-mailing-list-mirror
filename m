From: Bruce Korb <bkorb@gnu.org>
Subject: Re: SUCCESS -- failed to push
Date: Mon, 01 Mar 2010 14:04:18 -0800
Organization: FSF
Message-ID: <4B8C39E2.2050904@gnu.org>
References: <4B8C2E68.3020507@gnu.org> <4B8C303E.7050605@gmail.com> <a038bef51003011342j3d761d0cmd96d8641f96ed15@mail.gmail.com> <4B8C38E5.7090305@gnu.org>
Reply-To: bkorb@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 23:04:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmDj2-0003Ve-Pk
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 23:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab0CAWEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 17:04:23 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:59844 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab0CAWEW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 17:04:22 -0500
Received: by fxm19 with SMTP id 19so1260523fxm.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 14:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :reply-to:organization:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ARvVXBIA/YYViM9t0cmoGHkS867x+BgYb8YEliY+vwI=;
        b=N9MBt0Qu46gsUmdEjoH8lvWKdXLk44Xo8KMr0A5DHsWG527L83g6sNb8kKvtKv90pi
         m4nFmKYUjgA8pe9qqqABIecv178o6lKnqfqr9OfdWJrbDTsPrMz0Rei5RhsLLYLRT0Z8
         /N871yAWz9Yjdnd3n1cTwRbA2/NwPAjdZQM3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:reply-to:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=ELGvxSUW1vrxODqigfR3wycxVLondrsHxb6UjjqdnqcTrwg/WpAHdgTZAEH719oBP2
         TbaXeZUg0OylU9DWttBLatbjXK4ct5RhnPBN5jOFWHtfhdx0CVy9nsHJtq6jZyie7iR5
         qehXbnB92m9CCRbYjos+S8kvUfqSZslAjoxqU=
Received: by 10.87.11.34 with SMTP id o34mr8411511fgi.26.1267481061076;
        Mon, 01 Mar 2010 14:04:21 -0800 (PST)
Received: from [10.10.1.101] (adsl-75-0-176-14.dsl.pltn13.sbcglobal.net [75.0.176.14])
        by mx.google.com with ESMTPS id 12sm4721157fgg.29.2010.03.01.14.04.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 14:04:20 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4B8C38E5.7090305@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141362>

Bruce Korb wrote:
>> In terms of recovering from your present situation I'd try the
>> following (Disclaimer: maybe you shouldn't try these based solely on
>> my advice. I'm still learning too)
>>
>>   git pull
>>   <resolve merge issue, 'git mergetool' is your friend>
>>   git push
>>
>>   I think this will basically sort things out but you may need to hand
>> hold a few things through a merge depending on how different the 2
>> commits are.
> 
> I will be trying this procedure momentarily.

There were no resolution issues.  "git pull ; git push" was sufficient.
Thank you all for your help!  Regards, Bruce
