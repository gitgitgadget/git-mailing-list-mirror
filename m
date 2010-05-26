From: James Tucker <jftucker@gmail.com>
Subject: Re: bug with 'cl' as alias for 'clone'
Date: Wed, 26 May 2010 10:13:16 -0300
Message-ID: <CD06D0C2-BE89-4ECE-A453-CF5FD69A4B55@gmail.com>
References: <E4D176D9-E1D2-4C8F-8F18-11060E49ED80@gmail.com> <AANLkTinSKgn5IgO3F-gqy-7RTs36Xe_9NB1dvRQrq4SK@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 15:13:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHGQK-0005X7-I5
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 15:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246Ab0EZNNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 09:13:22 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:58856 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab0EZNNV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 09:13:21 -0400
Received: by qyk13 with SMTP id 13so9050866qyk.1
        for <git@vger.kernel.org>; Wed, 26 May 2010 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=Ovod+MGc3MnItk1M1Y8VKGN+o/RRG6LtEL3mc9LeyPA=;
        b=irtjxMTP1qdaiDkQy2nwX/bBEIvQ27YCCZcOPYe2NmS/Jvht+DxVerjg0gC947TusM
         I9DfANZ/J2y7QQBp93EU2nPJfIqesMRwE8pZJKjHdRTtO69zbcmW0JaU2U69pmbcWzIB
         fb9c19dOnBU2BfddmVr8jEo446rZ8X5c5ysOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=DLaL+uj4VfEv7u+toVghtKuvX4JPLLlNX71uzqj7uAgCO0ed5HzcgOwY2r/WhHwKUz
         pK3DqIvQPxmZIrnUaJnaAEhYwcMtvNrxcyxJfewsl8n8+puA5DOpPeYJVWIKzkiQNR11
         oCvfJ4C3yxaQnXZ+weofblsXiGF9vqCCZrufY=
Received: by 10.224.115.27 with SMTP id g27mr4754343qaq.311.1274879600179;
        Wed, 26 May 2010 06:13:20 -0700 (PDT)
Received: from [192.168.2.111] ([199.172.208.176])
        by mx.google.com with ESMTPS id 4sm299505qwe.35.2010.05.26.06.13.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 06:13:18 -0700 (PDT)
In-Reply-To: <AANLkTinSKgn5IgO3F-gqy-7RTs36Xe_9NB1dvRQrq4SK@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147795>


On 26 May 2010, at 10:07, Ramkumar Ramachandra wrote:

> Hi,
> 
> On Wed, May 26, 2010 at 2:48 PM, James Tucker <jftucker@gmail.com> wrote:
>> % g cl http://github.com/erikh/rdbi.git
>> fatal: cannot set work tree after initialization
> 
> I'm not able to reproduce this with Git 1.7. Which version are you using?

I was using 1.7.1.

Someone in the IRC channel 'doener' spotted it after some tracing and so on. I was cloning inside a working dir of another repo, and this was causing the problem.

Thanks to everyone for their help!
