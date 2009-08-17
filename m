From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 19:34:13 +0200
Message-ID: <4A899495.8050902@gnu.org>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-2-git-send-email-lznuaa@gmail.com> <1250525103-5184-3-git-send-email-lznuaa@gmail.com> <1250525103-5184-4-git-send-email-lznuaa@gmail.com> <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes.Schindelin@gmx.de
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:34:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md66J-0007pA-7w
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762AbZHQReR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757666AbZHQReR
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:34:17 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:33949 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbZHQReQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:34:16 -0400
Received: by gxk1 with SMTP id 1so4224916gxk.17
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Izr1hNSUoEQon3PwvQJUlXh5+83DT/jXUtrwJq6t5g4=;
        b=SWi6ixGnJPQwyRc8xrmUM75PBLpxmhmAwojJhVB9OU2RFY7M6K85bWiQDcCXcHq18V
         eF3+izErJQPpuJBCxXYwz9yBThYbdaZ9MoEutuUbJZO2wHiynLTHvGsRHDyVMG6m9kpH
         HsvFf3cNMnmLw1lWMb4bQZemv2IWNhCoPdsy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=FSy6ecbCjvDRxCxe2sYlc0HFUW4lN2UrVN6iV5ZScqt3dRXMAbuDx+1L9sxT0tGpBH
         f2Y/vR7WxVceIn0HmjQQ1dlmrf/EXY+Jp3jKT5ViWeQv3mAw6owAjgmUFFuYWwIs0KXg
         1zaYTjAZb+Wh2PpVqdTTAtepAf2tFrhspQvuY=
Received: by 10.91.95.5 with SMTP id x5mr2982260agl.28.1250530457758;
        Mon, 17 Aug 2009 10:34:17 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([72.14.241.7])
        by mx.google.com with ESMTPS id 5sm6829839agc.47.2009.08.17.10.34.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 10:34:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126244>

I don't know if this is in any way feasible (does not seem to hard 
actually), but I think these files should be automatically generated.

Otherwise, bitrot is going to happen in zero time.

Also, a cleaner XML without verbosities like

+			<Tool
+				Name="VCMIDLTool"
+			/>

would make the patch easier to review.

I agree with dscho on the non-builtins.

Paolo
