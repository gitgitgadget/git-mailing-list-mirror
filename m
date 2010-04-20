From: Brian Herman <brianherman@gmail.com>
Subject: Git and Very Large Codebases
Date: Tue, 20 Apr 2010 04:00:40 -0500
Message-ID: <h2w4ef15ddc1004200200ocd9df12azf62da7419355ae7c@mail.gmail.com>
References: <s2x4ef15ddc1004200158s2fc6391byfab91784036ac018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 11:01:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O49Ka-0004pe-IS
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 11:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab0DTJBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 05:01:05 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:60296 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab0DTJBB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 05:01:01 -0400
Received: by bwz19 with SMTP id 19so104363bwz.21
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:content-type;
        bh=wjQMFIhyMCMSY6M7JEHwE2EoZSx1fdSlI50+2zLMakQ=;
        b=EbarG5iqSOnRiUKAEj9ilG3Bi3yL/ujRxH7rJOv5XarEvqzz4l+dOd+5e63Zufc81x
         dCz2wd4nzXpDyuU8Pc+ivAHNrVx7OEZQK+BsmWuk0JHqSQjwFCWwYRN/wk+ExlCSXQXd
         +vI3xYoFE2KcI677h7m/by8EZnBM8VnczdeHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=COHVES3uvh1keJtuz6PhIQgZ9An6j19wtDr08OVc6FOkLAKXwwL52KHUwi1EjTxFkh
         7kMDR8ue4TwYZcyT/VBRAs+o65DFA7jvZrpjBpCozBh6duGduxBFT9ladVltFhd/4TWc
         lb/QT5hMV5J4+7UBGbAigvKzbRhKO52sLjYJY=
Received: by 10.239.163.18 with HTTP; Tue, 20 Apr 2010 02:00:40 -0700 (PDT)
In-Reply-To: <s2x4ef15ddc1004200158s2fc6391byfab91784036ac018@mail.gmail.com>
Received: by 10.239.137.11 with SMTP id j11mr606330hbj.177.1271754060153; Tue, 
	20 Apr 2010 02:01:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145358>

Can git support codebases on the order of magnitude of Gigabytes?
For example, a game developer might want to use git as their SCM
software but their codebases can be in gigabytes in scale.
If git cannot support this how would one begin to create this support?

--
_________________________________
Thank You,
Brian Herman
