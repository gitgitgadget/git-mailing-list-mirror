From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 1/2] cmd_clone: free dir and path buffers
Date: Thu, 31 Mar 2011 17:06:29 +0200
Message-ID: <1301583996.11592.3.camel@bee.lab.cmartin.tk>
References: <1301581122-19947-1-git-send-email-cmn@elego.de>
	 <AANLkTi=XYv1WFbvHwqvrJDkssKC-zU91Vj4EPbZG6OK2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 17:06:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5JSU-0005Sn-HO
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 17:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab1CaPGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 11:06:43 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:43368 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757716Ab1CaPGn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 11:06:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 2F9A81B4CC0;
	Thu, 31 Mar 2011 17:06:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwWL6mL8IcrF; Thu, 31 Mar 2011 17:06:37 +0200 (CEST)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id D453F1B4CAE;
	Thu, 31 Mar 2011 17:06:36 +0200 (CEST)
In-Reply-To: <AANLkTi=XYv1WFbvHwqvrJDkssKC-zU91Vj4EPbZG6OK2@mail.gmail.com>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170497>

On jue, 2011-03-31 at 10:45 -0400, John Szakmeister wrote:
> On Thu, Mar 31, 2011 at 10:18 AM, Carlos Mart=C3=ADn Nieto <cmn@elego=
=2Ede> wrote:
> > The variables dir and path are always allocated on the stack so it'=
s
> > always safe to free them.
>=20
> I think you mean "on the heap". :-)

 Indeed I do=20

   cmn
