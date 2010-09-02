From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 11:33:48 -0400
Message-ID: <4C7FC3DC.3060907@gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com> <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 17:34:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrBnd-0001EP-Q6
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 17:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab0IBPd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 11:33:56 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49345 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab0IBPdz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 11:33:55 -0400
Received: by yxp4 with SMTP id 4so191773yxp.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Xl/Ubhfx2R+JYDQ0QGw0AN8U2Rw+4nA7FYIF1C/Lncg=;
        b=wYwdJzeOFw+zs3REhG5qS33oR0J0zhfgBuHPcjWcIeNEqF2+gF0p8xXYxfQt81Undf
         7Vj9y9LdKTgtI1/K6N/yHr/PCbYRNQ+hk5bCRHB/v0iowOYuThB9uPhOVE/ji/u368J8
         maBRZDJI6h5cHF1L530D62jm25WjW+f36sEK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=kn4EWHrtqDT+z5nDWQofvhrQQCdBd+P4tyyhPgjzLBskCf9C0CrWObz/D8A2IkC7vp
         CsBq833lhiHaAcYem6ec+jgeicM/dkjJmGze73MBfZksQuTpqzTxGPLrMrOPRSSHBDK5
         pR6Fc9ol184Yj+h5nhxQBksCmhCtuMz7CFkcQ=
Received: by 10.101.152.40 with SMTP id e40mr10348393ano.198.1283441634905;
        Thu, 02 Sep 2010 08:33:54 -0700 (PDT)
Received: from [10.0.1.130] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id w1sm907777ana.36.2010.09.02.08.33.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 08:33:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100805 Icedove/3.0.6
In-Reply-To: <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155135>

On 09/02/2010 09:37 AM, Luke Kenneth Casson Leighton wrote:
> On Wed, Sep 1, 2010 at 11:04 PM, Nguyen Thai Ngoc Duy<pclouds@gmail.com>  wrote:
[...]
>> There were discussions whether a pack is stable enough to
>> be shared like this,
>
>   it seems to be.  as long as each version of git produces the exact
> same pack object, off of the command "git pack-objects --all --stdout
> --thin {ref}<  {objref}"

This is not guaranteed.
