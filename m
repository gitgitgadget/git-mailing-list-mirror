From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v4 31/45] rebase: trivial cleanup
Date: Tue, 11 Jun 2013 19:24:16 +0200
Message-ID: <20130611172416.GB20009@paksenarrion.iveqy.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-32-git-send-email-felipe.contreras@gmail.com>
 <20130609191518.GB12122@paksenarrion.iveqy.com>
 <7vhah4d3sk.fsf@alter.siamese.dyndns.org>
 <20130611170815.GA20009@paksenarrion.iveqy.com>
 <CAMP44s0VksnZmi21u6T79AvMebWA3gXmWbQ6pp=FAHL=D4q6+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:21:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSGA-0005FQ-Ec
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab3FKRV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 13:21:26 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:57743 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab3FKRVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:21:25 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so7174463lab.33
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ejkdDuQG5H/zHdPBGW1qM9d3Nn/fLDLmfLRY87Eo6RY=;
        b=AXN6BoPJoXHnIcYk9+MZCnTDeRxGJn+k+eXdpILj9sETzM/s/dVtLzkKNx0T3ooEvq
         4RT+1NXWgWoHn+r/f1udwLAM3203oZ6yvJvJAniXJU/dB14/gWXkcz7DpBoST6Wl+589
         r0aYxYckDyUJ4RrViBNeOVVpiIFTaVgDNMQUszD/OkyOYOC7R43FvQiab/EmHZ7gPZqe
         N+fTcRXZVeFh6MZ1IYKYuONNmXVFaLUc91FaUQW1DM24UZeUKqwRSOn+AO+bJMTwp5s9
         YAjtTIiWbDU6Rm0PVg7ZHKOqsUMyHItm5f8uD1+bsRnNDhgJHiWL86jBLtyJvF2BIxPV
         yqVA==
X-Received: by 10.112.142.228 with SMTP id rz4mr9186806lbb.62.1370971283696;
        Tue, 11 Jun 2013 10:21:23 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id uo8sm7801114lbb.5.2013.06.11.10.21.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 10:21:23 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UmSIq-0005ls-81; Tue, 11 Jun 2013 19:24:16 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s0VksnZmi21u6T79AvMebWA3gXmWbQ6pp=FAHL=D4q6+Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227470>

On Tue, Jun 11, 2013 at 12:09:32PM -0500, Felipe Contreras wrote:
> It's not removed. It's simply moved.

Sorry about that, I wasn't paying enough attention. But why are you
moving it?

All other arguments to git am is set in git-rebase.sh, why just set
-q just before the invokation in git-rebase--am.sh?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
