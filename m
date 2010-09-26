From: David Ripton <dripton@ripton.net>
Subject: Re: [PATCHv5 01/12] gitweb: introduce remote_heads feature
Date: Sun, 26 Sep 2010 15:47:43 -0400
Message-ID: <4C9FA35F.4090800@ripton.net>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>	<1285344167-8518-2-git-send-email-giuseppe.bilotta@gmail.com>	<201009261924.06237.jnareb@gmail.com> <AANLkTikotGEOOeUOwz03xtL09fV+oycV3yG1O4hQhoQB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 21:47:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzxCV-00025t-6E
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 21:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757988Ab0IZTru convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 15:47:50 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:47688 "EHLO
	homiemail-a42.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757315Ab0IZTrt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 15:47:49 -0400
X-Greylist: delayed 150004 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Sep 2010 15:47:49 EDT
Received: from homiemail-a42.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a42.g.dreamhost.com (Postfix) with ESMTP id B2C2768C06B;
	Sun, 26 Sep 2010 12:47:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=ripton.net; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=ripton.net; b=
	GV+1DiBRMxnfbbRvMrpOT1rb+h6vDjsXS+yQPgoNGjtdGg2cPOgpLy2tiBeeV4O/
	NGFhoEwK2OPhmp6B13TJ1i1rKouR9AkIMvGfFX0c0D4svZmqXPHqHjlfrv6k8iq7
	ocQ4BKG2k7j77CvXOJDkaoe+xs4u6AzATNMiK9d13ow=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ripton.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=ripton.net; bh=0mUSlZ
	rmcM/M5N3YNWOscD+S3XE=; b=3yh1ak98r/uy6+cLnyXvmAdmeyiLHPMjG4En4r
	Wsk76Mdxkahy2eOiVxx3ynUqq4VvwwodZvr8gd5Hjhs7LPQVYeFbsGEGOW1jmV86
	+zcOaSR/+X6tHzl8t+SA9JohVWK8O7Ps7h2IYirv0xMIE0QaI80sWWYEcYsp11YW
	hOLdo=
Received: from [192.168.2.175] (pool-98-118-245-254.clppva.fios.verizon.net [98.118.245.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dripton@ripton.net)
	by homiemail-a42.g.dreamhost.com (Postfix) with ESMTPSA id 3438568C065;
	Sun, 26 Sep 2010 12:47:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.9) Gecko/20100908 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <AANLkTikotGEOOeUOwz03xtL09fV+oycV3yG1O4hQhoQB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157256>

On 09/26/10 15:19, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> 2010/9/26 Jakub Narebski<jnareb@gmail.com>:
>> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>>> +     # Make gitweb show remotes too in the heads list
>>
>> Very minor nitpick: it should probably be (but I am not a native
>> English speaker, so I migh be mistaken)
>>
>>   +     # Make gitweb show also remotes in the heads list
>
> Maybe:
>
>      # Configure the display of remotes in the heads list
>
> or
>
>      # Toggle the display of remotes in the heads list

IMO either of those are fine.  Or you could just swap a couple of words=
=20
in the original message to make it sound a bit more natural:

# Make gitweb also show remotes in the heads list

--=20
David Ripton    dripton@ripton.net
