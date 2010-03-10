From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Tue, 09 Mar 2010 18:14:36 -0800
Message-ID: <7vfx48udmb.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com,  git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: 3mwCXSwcJB34ikvuvgtrqdqz.eqoou0uikviqqingitqwru.eqo@groups.bounces.google.com Wed Mar 10 03:15:12 2010
Return-path: <3mwCXSwcJB34ikvuvgtrqdqz.eqoou0uikviqqingitqwru.eqo@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f159.google.com ([209.85.221.159])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3mwCXSwcJB34ikvuvgtrqdqz.eqoou0uikviqqingitqwru.eqo@groups.bounces.google.com>)
	id 1NpBS3-0003N8-KS
	for gcvm-msysgit@m.gmane.org; Wed, 10 Mar 2010 03:15:11 +0100
Received: by qyk31 with SMTP id 31sf12311147qyk.27
        for <gcvm-msysgit@m.gmane.org>; Tue, 09 Mar 2010 18:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:received:to:cc:subject
         :references:from:date:message-id:user-agent:mime-version
         :x-pobox-relay-id:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=WZe01hDhpanfSy1C3o248CWWwmjAwQq5IKGFncoRocU=;
        b=MeScepSgSwczNijQqgIufhYNwXmGTAwUOKz9HVTXUmpp/eIT4OHhj60BX9lts65J8v
         ip+uQ5AV0SOWPfTOohllinW4mxqDKEtr27H1NVCkpVFG2VuSaP8bLxTFci2F0X2QF9uc
         3sk8UKuK3nJP2iLaB429vzZnAgo6T8KQewND0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:to:cc:subject:references:from:date
         :message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type;
        b=pQw2HcX8Pvcw7e0kLDF+bElgonrKbVLQXNdrGcNNnIwaMszCxFuQ/ceX7qWwDLWMjn
         ilmqCuQwuBt8Sev7mLf+951DzVmFnKuV+Ulr3uy0pELP1aFmKLsJ2F48n9l+AssxepXT
         pQspYiwrl1JeU3X8UgKGPXAErtNk4vHgv41eQ=
Received: by 10.229.105.79 with SMTP id s15mr35931qco.45.1268187291442;
        Tue, 09 Mar 2010 18:14:51 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.229.50.82 with SMTP id y18ls752554qcf.1.p; Tue, 09 Mar 2010 
	18:14:47 -0800 (PST)
Received: by 10.229.230.194 with SMTP id jn2mr124585qcb.12.1268187287229;
        Tue, 09 Mar 2010 18:14:47 -0800 (PST)
Received: by 10.229.230.194 with SMTP id jn2mr124584qcb.12.1268187287200;
        Tue, 09 Mar 2010 18:14:47 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-pb-sasl-quonix.pobox.com [208.72.237.25])
        by gmr-mx.google.com with ESMTP id 18si1596012qyk.12.2010.03.09.18.14.46;
        Tue, 09 Mar 2010 18:14:46 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B920BA0E88;
	Tue,  9 Mar 2010 21:14:44 -0500 (EST)
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D0E7A0E86;
	Tue,  9 Mar 2010 21:14:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1BA6A0E83; Tue,  9 Mar
 2010 21:14:37 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AFB7B9D8-2BEA-11DF-B0A1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) 
	smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
X-Original-Sender: gitster@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/1a323b5ee3684208
X-Message-Url: http://groups.google.com/group/msysgit/msg/b93fb1c06da37790
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Git Release Notes (Git-1.7.0.2-preview20100309)
> Last update: 9 March 2010

In case somebody is wondering where to download this from...

    http://code.google.com/p/msysgit/

is the URL to visit ;-)    

Thanks, msysgit folks.
