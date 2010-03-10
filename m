From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 15:22:23 +0100
Message-ID: <4B97AB1F.8060406@viscovery.net>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>	 <46d6db661003092258t22f2ee5ga720f18a859db957@mail.gmail.com>	 <alpine.DEB.1.00.1003101329550.3006@intel-tinevez-2-302> <46d6db661003100519v7fe84ffg4ffb1cf3aae15778@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 msysgit@googlegroups.com, git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: 3I6uXSwYNB7Ea.jZokmZjTfmVip.eVkdjpjXZkXffXcVXiflgj.Tfd@groups.bounces.google.com Wed Mar 10 15:23:14 2010
Return-path: <3I6uXSwYNB7Ea.jZokmZjTfmVip.eVkdjpjXZkXffXcVXiflgj.Tfd@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f188.google.com ([209.85.217.188])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3I6uXSwYNB7Ea.jZokmZjTfmVip.eVkdjpjXZkXffXcVXiflgj.Tfd@groups.bounces.google.com>)
	id 1NpMoB-0006EN-ML
	for gcvm-msysgit@m.gmane.org; Wed, 10 Mar 2010 15:22:47 +0100
Received: by gxk4 with SMTP id 4sf14060415gxk.6
        for <gcvm-msysgit@m.gmane.org>; Wed, 10 Mar 2010 06:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-spam-score:x-original-authentication-results:x-original-sender
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :x-thread-url:x-message-url:sender:list-subscribe:list-unsubscribe
         :content-type:content-transfer-encoding;
        bh=F3yMEHI5vDc+VEjkpEKhJNDE1VGvDJKDGn7VeQnRGOk=;
        b=RdfUKh30iMwavKUwvJ/mzQ6SnbnWQudkxHC2w++YVmCckK9NiznZmorW4Qbejpll94
         lXvpMK4b9rsU6EQbgZxQ08bxAjjOZhKprLWayADWU9OTbcFxaduDtcyH7tgJRvrz0wOD
         sqTOQWpWrioEvcJ4YKXLxlfHNhvJ3ud88HnW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-spam-score
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        b=hrYM5U8fgNegP+NZzJOOoM9oKG4aFjvzjex9Y1N7lD7x5oLLOKdOPByg0Z/XJ5Boka
         jvo9bXweKVmpUhFX0O9X3CbFg3PtoylY38tFDGe5CuWggcSOiMxAu4FZQ+E2x+un+fd6
         anij5oBi6/AVBlVN7rZjhC+d4jwE+Cxo5nRqs=
Received: by 10.91.93.19 with SMTP id v19mr24181agl.18.1268230947799;
        Wed, 10 Mar 2010 06:22:27 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.156.19 with SMTP id u19ls759643bkw.2.p; Wed, 10 Mar 2010 
	06:22:25 -0800 (PST)
Received: by 10.204.144.15 with SMTP id x15mr91023bku.39.1268230945738;
        Wed, 10 Mar 2010 06:22:25 -0800 (PST)
Received: by 10.204.144.15 with SMTP id x15mr91022bku.39.1268230945717;
        Wed, 10 Mar 2010 06:22:25 -0800 (PST)
Received: from lilzmailso02.liwest.at (lilzmailso02.liwest.at [212.33.55.13])
        by gmr-mx.google.com with ESMTP id 18si490761bwz.8.2010.03.10.06.22.25;
        Wed, 10 Mar 2010 06:22:25 -0800 (PST)
Received-SPF: neutral (google.com: 212.33.55.13 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.13;
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NpMno-0004Bp-K6; Wed, 10 Mar 2010 15:22:24 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4D47B1660F;
	Wed, 10 Mar 2010 15:22:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <46d6db661003100519v7fe84ffg4ffb1cf3aae15778@mail.gmail.com>
X-Spam-Score: -1.4 (-)
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	212.33.55.13 is neither permitted nor denied by best guess record for domain 
	of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/1a323b5ee3684208
X-Message-Url: http://groups.google.com/group/msysgit/msg/10fabfdf9bb5054e
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141904>

Christian MICHON schrieb:
> On Wed, Mar 10, 2010 at 1:30 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> On Wed, 10 Mar 2010, Christian MICHON wrote:
>>> This one feels weird here on Vista: .gitignore or .gitattributes end
>>> up having no name visible at all on Explorer file view. I can only see
>>> their real names once I fire the editor, on the title bar of the
>>> editor. Is this expected ?

Yes, when you have your Explorer in luser-mode. Go to the Options and
*turn off* "Hide extensions of known files types". This unhides the "file
extensions" .gitattributes, .gitignore, but also .txt, .doc, etc. that
Windows knows about. :-P

-- Hannes
