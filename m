From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 23:43:14 -0500
Message-ID: <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com>
References: <478E1FED.5010801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 05:43:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFMba-0006pC-Np
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 05:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbYAQEnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 23:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbYAQEnQ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 23:43:16 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:13490 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYAQEnP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 23:43:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so841304wah.23
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 20:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=i9U71ZN4j9uTJkKe8E2kkzzPZY8CWXo+n+nU0l3EMak=;
        b=hDv5GmlrtypGz5c4j+8d911KZkctiQ2EVOnNGcWpSLgoQ80IWiKPTmgyTB61jsCIXCWpEdptOf/BbEaqY+BhYrt1W6zIMZgE0hB3tx6nUSG8XuV7VXOLk/xcV8YM9uvbVRhKpdfdgYuzqDi3m9vdxZpe5MWun0wxjxGhGZOAje8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Qu+zUav1BBP2L9jzHvnv1BOzl2mH8+Oq/tF/nI7uRELqFhYLkdp/LI2S3wG+b3ZMNxYDJPn6d8HBkn98/BiRxpyM6D5+3mv7IpdL+/Uac1xx+/6mHqCpTFav1hJRBDOi43+U4WX5fMoXeU3qfja7fsDNaiaBzpgm8BT/fTseNRY=
Received: by 10.114.59.1 with SMTP id h1mr1907936waa.39.1200544994645;
        Wed, 16 Jan 2008 20:43:14 -0800 (PST)
Received: by 10.114.14.17 with HTTP; Wed, 16 Jan 2008 20:43:14 -0800 (PST)
In-Reply-To: <478E1FED.5010801@web.de>
Content-Disposition: inline
X-Google-Sender-Auth: d2fba81174dc6212
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70824>

FWIW, here's Sun's take on the issue of filesystems and i18n:

http://developers.sun.com/global/products_platforms/solaris/reference/presentations/IUC29-FileSystems.pdf

j.
