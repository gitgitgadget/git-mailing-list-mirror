From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/3] completion updates
Date: Mon, 23 Mar 2009 03:26:48 -0700
Message-ID: <1237804011-15419-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:28:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhOS-0003Bn-NK
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbZCWK05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbZCWK04
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:26:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:62623 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbZCWK0z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:26:55 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1710380rvb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=WoA7zMrX/1FhzGgga5oJuxv5PaRNzPic6Z28oHbReHc=;
        b=kCoXwDdmVKGEK2s3IK6WMiiG5/rjWgk+8kSW2q4/ba3flV3MrBMJmoWa48PbuhFXo5
         CP3j1pl+/xPUW/tCMSpuWtEagPtMt+GHbgCyEJ9e3WVNu8iA56yHBj2xbQHRfERijP/8
         bxUaEQi/kw0oz8d2SGIZF3EgA141RNCOfyges=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AHaBKAUHT7NYXykEhWu/Q4ww7BQ+w6uDzwhQEtEYHLxsAjNx2qWv4WdnhN2fm6ggJn
         KMP+AVru2d96tgxoFcNZH4nVhq1b4cKC7lDPZ39G74KMAM7se3gzcYAoWN85qF6mBwq8
         UoqmtOQcFL+rytuB4OV4jqByiytv0XFLGmz+U=
Received: by 10.114.106.13 with SMTP id e13mr4704253wac.52.1237804014160;
        Mon, 23 Mar 2009 03:26:54 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id m34sm5183299waf.1.2009.03.23.03.26.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 03:26:53 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 23 Mar 2009 03:26:51 -0700
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114275>

Stephen Boyd (3):
  completion: add --annotate option to send-email
  completion: add --cc and --no-attachment option to format-patch
  completion: add --thread=deep/shallow to format-patch

 contrib/completion/git-completion.bash |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)
