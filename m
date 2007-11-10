From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: gitweb, updating 'last changed' column on the project page
Date: Fri, 9 Nov 2007 20:09:08 -0500
Message-ID: <9e4733910711091709k173bf23flf2824673f82de9bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 02:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqeql-00055s-IE
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 02:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760058AbXKJBJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 20:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759730AbXKJBJK
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 20:09:10 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:26633 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759431AbXKJBJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 20:09:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so777874wah
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 17:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=5gv2jZGSFbc3vGObOcKIgGpc88rggRymioDAdxRvBy8=;
        b=ari/pnrHHkX/j17ci22ufmdIVXoAdmJ5U6Ea6BVXEOm/0m1On1gnZdN7KUAtMfU+unawKuwiZvACLTT6m6Tnb1bATNRma8TWQSuKC38yKzENaivS2du4+IaLIdH3DnYoMYYF4c/PlUdqrfk1rwE2zo6w5jYoIqH08hwxlkumQC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aG8akUyOGhD9pc+w8SIDim0hcMPbaciGcu1Xs0eIOcumB5N82fsH/UEsg0Nl3qWhHYN1QU9VDSx2UZC4VXOP9RJwb7JE3TCya06df3HNQ1Ce2uIEv8l5InIYJRN73Lra34dWkadI/XE2a8EunUzFd3wp/zulhjKWQayq/noJfNs=
Received: by 10.114.120.1 with SMTP id s1mr663026wac.1194656948284;
        Fri, 09 Nov 2007 17:09:08 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 17:09:08 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64295>

At http://git.digispeaker.com/ the 'last change' column is not getting updated.

mpc5200b.git
	DigiSpeaker for Freescale MPC5200B.
	Jon Smirl
	5 weeks ago
	summary | shortlog | log | tree

It still says 5 weeks ago, but if I click on the project last change is today.

What controls this? I tried running update-server-info

-- 
Jon Smirl
jonsmirl@gmail.com
