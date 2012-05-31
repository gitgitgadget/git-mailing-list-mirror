From: =?ISO-8859-2?Q?Tajti_=C1kos?= <akos.tajti@intland.com>
Subject: git-smart-http reject push
Date: Thu, 31 May 2012 22:38:38 +0200
Message-ID: <4FC7D6CE.30802@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 22:38:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaC94-0004uL-40
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 22:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab2EaUiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 16:38:54 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:55504 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab2EaUix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 16:38:53 -0400
Received: from [192.168.1.101] (92-249-245-147.pool.digikabel.hu [92.249.245.147])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Mgrky-1SMuRk1jhw-00MZYE; Thu, 31 May 2012 22:38:48 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
X-Provags-ID: V02:K0:JKmR/w/zw5z/or1v8NhlwLQL9qpaxO8GtB/DkPo87ev
 IQpywuuTpsOgSTfIj0rBbQeRMoiFMxZudgFJIV8uuUL0ZnJdMT
 RerJH+zHSFav5lIRMNQ/XnCgtB1mqKZOKYULbYa4emQv8CRMsM
 hBtaKU//4RJp7p0Kur+DXRFvUBA74+o/Go0j6KEZCKuOM6shNI
 D/SiHxApj2wJ+cylDgjZ0pZljG3eN/rVl+c2hQfsrTOhS3wyV0
 wGmGxMjxjzV001mMCbWttcWSIjl+Dh9jPuvMCMDJFK3bIlZS3I
 jMOPxy+tKpLCVutMe1pBtCITwUspwCPm6EYUqaPaz1z5gfI91j
 muGuoFQ5+8T60K2mUJmo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198947>

Dear List,

we wrote a servlet that is basically a proxy for git-http-backend. We=20
want to control who can create a new branch. Is there a way to reject a=
=20
push that would create a new branch (without using hooks)?

Thanks in advance,
=C1kos Tajti
