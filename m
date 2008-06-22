From: Lea Wiemann <lewiemann@gmail.com>
Subject: gitweb: broken link in atom view
Date: Sun, 22 Jun 2008 22:16:51 +0200
Message-ID: <485EB333.5070108@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090408030208000104040306"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 22 22:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAW0d-0008Mv-5P
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 22:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbYFVURB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 16:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbYFVURB
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 16:17:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:55279 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658AbYFVURA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 16:17:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so995785fgg.17
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:subject:content-type:from;
        bh=QOUjh/tI9Jr7uEQJ6hZ8CeiI8Hf+uRyjS8zCtPCugro=;
        b=PoheP6u28Gg/L4aHyPw8ovA6IIRb9wyLez5z1WxZ0od+re2VlrBhOEBc093UxV4KKG
         RHa7d+TutMnVmrAO+/TxQaCCEMzrxEDuXUv6xUAl/Y0mMyE2zzSVG/U2mFuGoGKFlr94
         4BFc8wb+YoHdCMExRlvmTUMb4I8P2dQ6GnMeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type
         :from;
        b=HdqToRJwNRPTvtskI4JqLzcHkXpT+yff7IisD8AYIB9Z6QLvpv222bu9aIJetyWv3a
         EuWekOec1TB4fuNSvJ5tavYNZPLTS6gQj/s721Vpvj3++NTRkwM5nLwJy5sqxIw+4FVZ
         s6us7MM/sbh/MZDIySWF/j6DXYLln9JMbIEho=
Received: by 10.86.68.20 with SMTP id q20mr7429232fga.2.1214165818122;
        Sun, 22 Jun 2008 13:16:58 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.209.241])
        by mx.google.com with ESMTPS id 4sm8701146fge.5.2008.06.22.13.16.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Jun 2008 13:16:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85799>

This is a multi-part message in MIME format.
--------------090408030208000104040306
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Linkchecking gitweb's atom feed on a test repository reveals a 
(solitary) broken link under certain conditions.  I can't deal with it 
right now, but maybe someone wants to look into it?  Here's how to 
reproduce it:

1. Unpack test.git.tar.gz (attached) into gitweb's project root.

2. Make sure $feature{'blame'}{'default'} = [1]; is on in 
gitweb_config.perl.

3. Download http://localhost/.../gitweb.cgi?p=test.git;a=atom

4. Locate the following link in the atom feed: 
http://localhost/.../gitweb.cgi?p=test.git;a=blame;f=renamed_file;hb=037554ed1a38b5112181208ac5a02ab461c4d305

5. Access the link -- it yields 404.

-- Lea

--------------090408030208000104040306
Content-Type: application/gzip;
 name="test.git.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="test.git.tar.gz"

H4sICJuxXkgAA3Rlc3QuZ2l0LnRhcgDsPU1sJNlZXgKCLpACQZEIAuWl7azddld3V//6Z+1Z
jz27M2RnZzPjYRWNx55XVa+6K66u6q0fe3pnjBIOiAvKAYkjuUSKlAu5oOwpQkhw4ZCAEAeu
gAQHbgghDojve+/VT//YbXvsns2mn6anu6vez/f/vu97X7VDFoSlth2W526uVaC1Gg1811qN
SvY9bnOaVqm2GrVKU2vOVbRKq1KfI40bhClpURBSn5A5h9Fz+026/zPawpj/PrOCGxKCy/Nf
a9ZrM/5Pow3yP6TtGxCCy/O/2qxoM/5Pow3yv8Ooef0CcAX+t6qtGf+n0RL+6z51jQ67iT3g
Cvyvt2b6P5WW8L9HjSNmqmgGrnsNZHCzXj+T/zWtNsT/GriAc6Ry3YCMaz/n/J8nyHjOdnJi
h5110mPMYSZRGjVN11cNYE7VXGXNVsNsra3prZpZZ0arqtVXK7pW17UayewcuqJbDcOsskqr
uUoZq9RNfa1Ra9UrLdZarbO6abJ6fa3WYNlRXRqEzFdaZqu5tlrVLG2t0oQBRq3GtNUmNfVK
vVrVISjQGFtlayR1VRBiNeh3Hds9Ul43KX8mW6L/79zZ27l7ePfO9u61rzFJ/yut6rD9r9Zn
+j+VdlEtz+WEg0AW9UXiWaQ0U7fPREv033ZN9vxm1pik//WqNhz/t2q1mf5Po+3ee7gDb78A
r8/dPfjhMV6L3+fmfuWNud/41q/NzX37e3D738Vr7pcf3tE+/s5f/v1Xv+DefWfn17/7yT8e
bv313Bs6jovk+Cgz/o2h8b/5P3/zJ8U//rufWJ9/99Z3vrD1L+oPf/oPP577Rct2mBh1BhwA
47f/MzPP79z+8he//vW/+r/1X/1B8N6/fum7//2/f/Fnfzj3SzhPlY/ae3jnDrx9aa5GKsqz
P//Bzvf++Ud/evxvv/XJ3/7kn5zfDX77vz55/MU/+Fzry8+KP/qjjfBbj//j+5//8U+nQPNP
U0v032SB4du90Pbc615j4v7fqA/7/1pDm+n/NFqpHK41KjUVROCE6ep9ZnSoa3/MSkGHoGyA
s93zAjv0/P5sx/8MtkT/b8TzF22i/ldbw/t/DfN/M/2/+Qax9PqYWPx1gzVrU2qJ/jveTRz9
8HaV8z+4Pcv/TqEN8v9mDoGvdP43O/+ZShvD/2s/BLw8/2vN1uz8fyrtTP7r17fGRP9vhP/1
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
AAA=
--------------090408030208000104040306--
