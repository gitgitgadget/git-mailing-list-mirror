From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v4 09/45] sequencer: remove useless indentation
Date: Sun, 9 Jun 2013 21:08:14 +0200
Message-ID: <20130609190814.GA12122@paksenarrion.iveqy.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-10-git-send-email-felipe.contreras@gmail.com>
 <20130609181724.GA11516@paksenarrion.iveqy.com>
 <CAMP44s3VL-uDPcsUyaYX3ESFbdj7h0XGuVZD+y8J_KewHcPC5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulkvs-0008Pw-K3
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284Ab3FITFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 15:05:36 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:46060 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab3FITFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:05:35 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so4011334lab.7
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6undT+3tL+4Db5BkxOFkf78VqG7TIjizh0nMsZONY5s=;
        b=n4ZlzE/+T8nJrUFeCzVTqeddHCjzBbkgo7Wvd57YgO7KmxAquftUdgwxuMRMbd6le/
         txMmN4wM+mz3F6BshJi9XSnQKza+61swXvLJr6oSgvTMhA6ygvv/SV8LfUsl7kS2OtM/
         1IFYFtZgjh3UCh474da5g35SwdGCjLu23scGRhZ6mf8TmgJVcigMdvMU8zm2OsDSh628
         LTfIRDeMX1ID1C+eFYRrudIoUATM4KhEhsmFdmQZWw/LK8L+GZiPITdSoWYLZ1oCFNL8
         cpNg8JoCoBD9SISoHFldBgdNOTGUwJEeJcjMVzg3xNDxj3LzCpQSV3d7G3Rigb7hL/b/
         Y8mA==
X-Received: by 10.112.190.74 with SMTP id go10mr5052212lbc.72.1370804732695;
        Sun, 09 Jun 2013 12:05:32 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id zo6sm4443195lbb.9.2013.06.09.12.05.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:05:32 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UlkyM-0003CJ-1H; Sun, 09 Jun 2013 21:08:14 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3VL-uDPcsUyaYX3ESFbdj7h0XGuVZD+y8J_KewHcPC5g@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227100>

On Sun, Jun 09, 2013 at 01:19:03PM -0500, Felipe Contreras wrote:
> The explains what the patch is doing, but not why. Why is more import=
ant.

You're right. Why are the indentation useless? It doesn't seem to be
useless until you added goto. So why is your goto solution better than
the previous existing solution?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
