From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: git's is_inside_git_dir too strict?
Date: Tue, 6 Mar 2007 22:41:14 +0700
Message-ID: <fcaeb9bf0703060741l7cbfd0f3ue443730176606db6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 16:41:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HObmw-0004Uk-D4
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 16:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbXCFPlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 10:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbXCFPlR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 10:41:17 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:40609 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965160AbXCFPlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 10:41:16 -0500
Received: by an-out-0708.google.com with SMTP id b33so1793673ana
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 07:41:15 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=egzbxprXE1izpydoJusU2ZZmER2lok3g4BHgjTSpowJmbNdJ9vBT55/w9hLWs/+D1lgmgiZxnRHv05CVTQThpN0+MrA5rOaK8HVUYACIYF8wZWplO8ssLUoX6eoaFriMQM2YYyMyqGdtrYw6CS95V0gIynI8f5lIJVcELuit2tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Sx4UnnZZiLytrqD71p8ot2IV9+a2hMyAF+a3cfKbxWfsMYBqnlce37nn4k0AO1YiXiLPwXZiXPjyiU8Qtz5LoDLHkFgFNMK0zZnZ16Bh0vWP+lLoRHl4UOeNMa/xOF3bY95c/YOHSDbgbredLAWjXbbMMIevC/9e/044czKbHFY=
Received: by 10.114.132.5 with SMTP id f5mr1772492wad.1173195674820;
        Tue, 06 Mar 2007 07:41:14 -0800 (PST)
Received: by 10.115.19.15 with HTTP; Tue, 6 Mar 2007 07:41:14 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41586>

Hi,

I have a working directory separated from its git repository. When I
work on this directory, I specify --git-dir argument (actually all
happens in script so I don't have to type that much). It used to work
but no longer since git 1.5.0. Complaints include "cannot be used
without a working tree" and "This operation must be run in a work
tree". Can I have the former behaviour back in some ways?
-- 
Duy
