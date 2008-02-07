From: David Kastrup <dak-mXXj517/zsQ@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 18:15:34 +0100
Message-ID: <86myqcr8ll.fsf@lola.quinscape.zz>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LFD.1.00.0802070949460.2732@xanadu.home> <20080207155946.GA20459@bit.office.eurotux.com> <FBE31353-CEB6-4563-AE5F-866D23D129EC@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 18:16:33 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.171])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNAMH-0004rn-U2
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 18:16:22 +0100
Received: by py-out-1314.google.com with SMTP id p69so2170469pyb.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 09:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:x-complaints-to:x-gmane-nntp-posting-host:user-agent:cancel-lock:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=41pHwzy514FhuzSvHllg78XHpSIMmWN4Is/LEndTkmU=;
        b=mNcHN2pRba/ys5eFHrmfGEhuUYzzQFIVfg1qf6ixKTCgeSthtO37JGy0xj/s0OFXRbQt7Jh2/CKQ/6teOb3h57WkwcSQRJhog90Sjl/pqHLst4OHT/0sg1LS+Wl37eoB9mEd9amToi0RlR1lxTrJgOqoxe0GMlLOGBe9yMHhLBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:x-complaints-to:x-gmane-nntp-posting-host:user-agent:cancel-lock:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=aEgMOmQzUf2nqWKA15bnL9jhYfU0y8QRgmDw8RBAhDscdPam195IsQetkXlJobalqK0RDMcwOWlpJuBJMGdn3uM5acTgwlyrfVEqg/ZGDZ7gz+UebmvJ1d49MrCa7OD8X+xIduYGyD2agfDTJziY22r4cK/2wh04lLODLPoOnaY=
Received: by 10.141.180.5 with SMTP id h5mr293409rvp.28.1202404545515;
        Thu, 07 Feb 2008 09:15:45 -0800 (PST)
Received: by 10.107.168.22 with SMTP id v22gr1655pro;
	Thu, 07 Feb 2008 09:15:45 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.59.5 with SMTP id m5mr25385226pyk.0.1202404545281; Thu, 07 Feb 2008 09:15:45 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id x46si6988793pyg.3.2008.02.07.09.15.44; Thu, 07 Feb 2008 09:15:45 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from list by ciao.gmane.org with local (Exim 4.43) id 1JNALe-0005hv-KV for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Thu, 07 Feb 2008 17:15:42 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 17:15:42 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 17:15:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:arwJ6tphnzwKRf+dU8tgP9GOO9g=
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72979>


Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:

> On Feb 7, 2008, at 4:59 PM, Luciano Rocha wrote:
>
>>> They nevertheless must be made aware of the rules they have to
>>> follow in
>>> case the idea of redistributing it crosses their mind.
>>
>> I don't dispute that, only that I can't continue with the install
>> unless
>> I click on "I Accept" to the GNU GPL.
>
> Simple question: Do you accept it or not?

It's not related to whether GPLed software is permitted to be installed
or not.  You could also ask "Do you like green eggs and ham?".  Where is
the point?

-- 
David Kastrup
