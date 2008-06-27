From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Adding a 'version' command to the server
Date: Sat, 28 Jun 2008 01:19:45 +0200
Message-ID: <48657591.9050805@gmail.com>
References: <7viqvupm3l.fsf@gitster.siamese.dyndns.org> <486572BC.9070201@gmail.com> <7vej6io4fy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 01:20:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCNFI-00033u-Ik
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 01:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763831AbYF0XTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 19:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760754AbYF0XTt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 19:19:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:14253 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759203AbYF0XTs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 19:19:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so340002fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 16:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=7en0B18wEyFRFJqND6GF0HyGPFVT2mQCOaQ92Ji4jfw=;
        b=HE1nlc9rve7O3eHVMzIAjvUvWFjJuledswluQgC0ZHeh66c2iPFmnAUu0KZ0+e2Z3k
         5RREjwubCXu/rrWMS4WJ3vSJatsWdX3ZPg+dtjAf3B2zFXe1hEBKuP5/wlfg0q/xEd3T
         zKOG9uwMmv83dl4ewKIYQOCUM4yOtVNTQ457E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=PGce+IMtMbpyk7l8iuXuxfAKyZ0K6T3LQXJOZThU3Dai02VGEgVy0dwx6fsfYNF4Hf
         CkzqyscY7lYxouI+hHWASaer09ogYVN4Pav11nzSC7F+mLidWfLekz1DjI81ohlRSzhZ
         M/ZweNuhaOPDlRv9Jf8mv8oUmAIKAGpl1HgR8=
Received: by 10.86.87.5 with SMTP id k5mr2570721fgb.59.1214608786916;
        Fri, 27 Jun 2008 16:19:46 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.234.14])
        by mx.google.com with ESMTPS id 12sm3860908fgg.0.2008.06.27.16.19.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 16:19:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vej6io4fy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86676>

Junio C Hamano wrote:
> Lea Wiemann <lewiemann@gmail.com> writes:
>> Junio C Hamano wrote:
>>> It is still possible to connect to older remote end with new clients, but
>>> you have to explicitly ask for "git-upload-pack" by using --upload-pack=
>>> option when running "git fetch"
>>
>> Now that the current git won't work with older servers anyway,...
> 
> Whoa, Wait.  Who said that?

I meant "now that the current git won't work with *some* older servers 
*without adding an option*".  Or did I misunderstand you?

-- Lea
