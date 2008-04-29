From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: format-patch --cc and send-mail --s-o-b-cc don't play nice together
Date: Tue, 29 Apr 2008 15:57:11 +0200
Message-ID: <36ca99e90804290657k88710eer630898d837659f37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ryan Anderson" <ryan@michonline.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 16:04:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqqRA-0008Bz-T0
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 16:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606AbYD2ODR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 10:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756092AbYD2ODR
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 10:03:17 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:23619 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538AbYD2ODQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 10:03:16 -0400
Received: by gv-out-0910.google.com with SMTP id s4so539gve.37
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=h80vP4f7TYbIEqqUIOG7zjAlhw7NQ/x6QFufjwly9a4=;
        b=wV3dla+W8XoJI9GgGeDZ01l8bHIkxLBm8wK8qys8APy8P93e3PHVG03YjCc6AblkRTI9SnYkDV+AUQXCPHMNypBEwutRxGCHevbQ4fgEGQqyJ1d8s6Lw9Tp8JeI2cllk4/0DNWZ2v6+BW6Urs/jQetD5c6fj0oi1A2aiz2+aKWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iKpEy1KMb7Q1GkWrtpZ9Hd3DVFLxjPx4nf3y/1FWIxKwxOCitX8COmaKw7H/EiVq88kZH/Z1tBgiaAGUNDLt1aDLJrvHMWvOo9adzDU+HpBUg6O/xWogOMvBU81dr56P7iSY3d84L4P2iaSMEnMO++DFOlSzvn5nnt9mCs1gLa0=
Received: by 10.150.204.8 with SMTP id b8mr5069344ybg.75.1209477431262;
        Tue, 29 Apr 2008 06:57:11 -0700 (PDT)
Received: by 10.70.31.15 with HTTP; Tue, 29 Apr 2008 06:57:11 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80684>

Hi,

the --cc option from format-patch adds a Cc: header to the mail where
multiple recipients are put into a new line, separated by commas.
Unfortunately send-mail with the --signed-off-by-cc option can't parse
these lines.

Any ideas how to solve this?

Regards
Bert Wesarg
