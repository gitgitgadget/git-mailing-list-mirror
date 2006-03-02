From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git-annotate dies when a patch is missing trailing newline
Date: Thu, 2 Mar 2006 13:53:21 +1300
Message-ID: <46a038f90603011653l7956d5dat99d88a7da98d21b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Mar 02 01:53:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEc4L-0004WX-KF
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 01:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWCBAxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 19:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWCBAxX
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 19:53:23 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:61859 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750851AbWCBAxW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 19:53:22 -0500
Received: by wproxy.gmail.com with SMTP id i32so283131wra
        for <git@vger.kernel.org>; Wed, 01 Mar 2006 16:53:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l022qQWWvDYZ07NKf5MdUXXuPJ+bV170rx3yyTYcv1NcXe3Q1H0psTI7tmlo+rDOEMv3vwPSsTkrf8Bg/OjQ8Muy7XzCVf3FXZD0UTLmQGZDMtcx5w5fGzWP5SmvGN/evTFRO9UUffFCsV9pUELaDCbQpbV1OFlS+4/3qvN8Y8I=
Received: by 10.54.153.11 with SMTP id a11mr362388wre;
        Wed, 01 Mar 2006 16:53:21 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 1 Mar 2006 16:53:21 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>,
	"Ryan Anderson" <ryan@michonline.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17037>

Ryan, (& list)

git-annotate is dying when a patch is missing trailing newline. There
_are_ valid situations where code files are not expected to have
trailing newlines. Just thing of that glorious programming language,
PHP.

(Ducks).

Actually, 99% of my usage of git is tracking CVS projects so this is a
bit of a problem.

I had fixed it in Johannes version, but I'm lost as to where to fix it
in the current git-annotate. Help?


martin
