From: Diego Calleja <diegocg@gmail.com>
Subject: can I get only the list of merges?
Date: Mon, 10 Jul 2006 19:26:22 +0200
Message-ID: <20060710192622.70c51a81.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 10 19:26:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzzWk-0001kl-BJ
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 19:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWGJR0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 13:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWGJR0b
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 13:26:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:42948 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422718AbWGJR0b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 13:26:31 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3968461ugf
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 10:26:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=kMH+w9LOZsg9QVNsvZZlCcp2ucks3EpgGhf/NQ70SVyNdZWUWajxbF5wMGVPG20bYztvyOojRG0naMrExU4npFL3q93SQ411MQ91f9UzCA8U/kOh3NMbC3Js2ODrmQh42/ecDAxfk5rcylgvl/QAgdGMQzWVfPc4CadjIM6G1tc=
Received: by 10.67.19.13 with SMTP id w13mr130618ugi;
        Mon, 10 Jul 2006 10:26:29 -0700 (PDT)
Received: from estel ( [80.103.5.157])
        by mx.gmail.com with ESMTP id c1sm3273654ugf.2006.07.10.10.26.25;
        Mon, 10 Jul 2006 10:26:26 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23628>

Hi, git-log and git-rev-list and friends have a --no-merges option. However,
I need the contrary functionality: a sort of "--only-merges" way of getting
the log? (that is, without parsing manually the git-log output)
