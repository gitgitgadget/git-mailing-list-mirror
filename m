From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn - failed to clone repository
Date: Wed, 23 Jul 2008 15:49:00 -0400
Message-ID: <32541b130807231249l1028a757i2f29e9ca6e38fc5a@mail.gmail.com>
References: <20080723160659.GB6705@cisco.com> <20080723170838.GK22606@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Derek Fawcus" <dfawcus@cisco.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?SZEDER_G=E1bor?=" <szeder@fzi.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLkLc-0001kI-OQ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbYGWTtF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 15:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbYGWTtD
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:49:03 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:5914 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYGWTtB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2008 15:49:01 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1121030ywe.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EscilD+zZY7UKMH3H1ldgfruuG5LOrbVH/pn7vCb8KM=;
        b=tpSSEzJd0u9wrRA7J7D6OJwNeSdPpdvBjvXlHWoVqV3uB9595+tjQ36vDoL9dqcRLv
         qynw2/r2SFgXdwp5sB0WKdHdJtVQPN8oHbA3CWI0JhsQQZzFMGg1anfPJ4EOFXxZl8RF
         J7eecBR2+7fPDHavW4J2w/gzwoo9dEIScYBTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qaRAAKJ0sVioZX76FZUtQ/bvqRgYcy/CgTf4y+BVjrpJ7QaSPRbbETtcS1noILTPQS
         YqLy0Wzs95wDISkxyCY1hv23yfx2OBaIlU0fHtovd0lHKchXBHmlNpxK1E7P7A+FfX9y
         dsSOtz6tXHX7yzShC3PqUGi2oo5dDhXZZymHw=
Received: by 10.151.112.4 with SMTP id p4mr73401ybm.141.1216842540374;
        Wed, 23 Jul 2008 12:49:00 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 23 Jul 2008 12:49:00 -0700 (PDT)
In-Reply-To: <20080723170838.GK22606@neumann>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89760>

On 7/23/08, SZEDER G=E1bor <szeder@fzi.de> wrote:
> It might not help you, but with svn version 1.4.6 (r28521) (from
>  Ubuntu 8.04) and current git master the above command has just
>  finished successfully.

I believe this was fixed by my patch
29c70e0b3e3183f86f93500882177d0c74069988, which was included in git
1.5.6.2.

Avery
