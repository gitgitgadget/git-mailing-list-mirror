From: Vitaly <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 18:35:11 +0400
Message-ID: <4BBC981F.1000802@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org> <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com> <4BBB53F5.9010106@op5.se> <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com> <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com> <alpine.LFD.2.00.1004061705390.7232@xanadu.home> <4BBC1E15.9040403@gmail.com> <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi> <4BBC3EEC.6010702@gmail.com> <alpine.LFD.2.00.1004071009180.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:35:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWM7-0004Dx-41
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574Ab0DGOfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 10:35:38 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:38971 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0DGOfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 10:35:38 -0400
Received: by bwz1 with SMTP id 1so879720bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=OUT/TgRJYqc0PmpzwjfB7dPHSsPQa4BC/UXg0BoSRUw=;
        b=UdUDkaB2h2tD0ov8O6pkqVxmwKHJis5XKNkUd5z3NQveh4soC4wMNOQPPF3nzIegYR
         zVmuOrrzhwu9HXQz003XO8XjyLvmqRf1GlfGtIGTSnxIJNXYQsFRXCNm5gxHXXNMqtpd
         iq3YXfRtFlEWRlx36YY2xyKyeEHslHqKgkyVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=DpvFRNDCTO50MBa74kEXS13FYZaU3Nw0vfn4tk9OmXzBtGW0/RCZweVuvf/8M0GJGE
         nCdiwQ37e9qyZQn7jdukpXwq8uv2H3UWudcHMOTN1LWoeefm/z2kwXviV7aIuFocCbFP
         LdH7AN+HiQhka3MMem5ydUA0lifaJzW1busVU=
Received: by 10.204.134.70 with SMTP id i6mr9228116bkt.74.1270650936330;
        Wed, 07 Apr 2010 07:35:36 -0700 (PDT)
Received: from [172.16.11.219] ([195.218.191.171])
        by mx.google.com with ESMTPS id 15sm7305013bwz.0.2010.04.07.07.35.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 07:35:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <alpine.LFD.2.00.1004071009180.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144223>

On 04/07/2010 06:20 PM, Nicolas Pitre wrote:
>> P.S. Btw, how can I ask for a feature of incorporating hashes into transport
>> stream in trusted environments?
>>      
> As I'm trying to make you understand repeatedly now, this shouldn't be
> needed.  A real fix for the bad behavior would be in order before
> papering over it.
>    
Nicolas, my post have been written before I received your message about 
reproducing and "stracing" the problem. I caught  your idea and now 
reproducing the problem.
My estimate is tomorrow (repack takes quite a long time).

Vitaly
