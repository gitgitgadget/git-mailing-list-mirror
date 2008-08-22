From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: About git pretty
Date: Sat, 23 Aug 2008 02:24:34 +0300
Message-ID: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 01:25:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWg0i-0002g8-DO
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbYHVXYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 19:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbYHVXYg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:24:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:26890 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbYHVXYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:24:36 -0400
Received: by nf-out-0910.google.com with SMTP id d3so316964nfc.21
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=5VVRen0z7AimnG5brsu1XY7TZmw3Z/IrdNVup1fqvus=;
        b=MUrAn8iBWLAR7D1x9XZ6/DGsPTwxkYONoC3w8ThchnTFV1o9h9ta7Gmrv4f37lgJsF
         xuwrA1mWjoOJYZlmJLVhdNyuOaxIr05HP+AuxIsLQXrkpJGej7fIQ7NhFytXJ/0GXWUc
         YBCCCCr2Mj9+HfCx02518SGnqbSF/BlREYLNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=xDxkFtz5G69VXTyGvTSuz60nWKzpl8cRmrwtP02OsBBilxOl30aOebT9+H7EEp9TNO
         5m4pyWfomPpi89PwpMX67ad+W8Ie4sf1DXgryOENE/jfu6FNhphiSzde1cBfa1uBuMwy
         eYR1U8CokHHUhN40M/iKDsnULHqxA0HV5zPjg=
Received: by 10.210.79.14 with SMTP id c14mr2245074ebb.139.1219447474494;
        Fri, 22 Aug 2008 16:24:34 -0700 (PDT)
Received: by 10.210.50.8 with HTTP; Fri, 22 Aug 2008 16:24:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93398>

Hi,

Please read aloud the following commands:
git log --pretty=short
git log --pretty=full
git log --pretty=format:%s

It is just me or 'pretty full' doesn't exactly convey the meaning of
the action to execute?

How about:
git log --format=short
git log --format=full
git log --format=custom:%s

If you like the idea I can work on a patch.

Best regards.

-- 
Felipe Contreras
