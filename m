From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC/PATCH 0/2] Support for arbitrary mapping for "git pull 
	--rebase"
Date: Thu, 18 Jun 2009 11:24:01 +0200
Message-ID: <adf1fd3d0906180224l668b4c84kc633ec13f8d0296@mail.gmail.com>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
	 <alpine.DEB.1.00.0906181040320.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 11:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHDqs-00032A-VE
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 11:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbZFRJYB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 05:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbZFRJYA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 05:24:00 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:62495 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbZFRJYA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 05:24:00 -0400
Received: by fxm8 with SMTP id 8so892019fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 02:24:02 -0700 (PDT)
Received: by 10.204.118.207 with SMTP id w15mr1140521bkq.126.1245317041787; 
	Thu, 18 Jun 2009 02:24:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0906181040320.4848@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121824>

2009/6/18 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Thu, 18 Jun 2009, Santi B=E9jar wrote:
>
>> Santi B??jar (2):
>
> Seems something is wrong in the --cover-letter utf-8 handlin, no?

In this case (the cover letter) it is send-email that handles the
utf-8, but I don't know why it is not working, as there is a test in
t9001-send-email that tests it. I think it worked, I'll try to bisect
if I found a working version.

Santi
