From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B v4 0/5] git config: reorganization
Date: Sat, 21 Feb 2009 02:53:16 +0200
Message-ID: <94a0d4530902201653p694bcad6wd79579536f285571@mail.gmail.com>
References: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:54:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lag8m-00087K-0w
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbZBUAxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753780AbZBUAxT
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:53:19 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:52763 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbZBUAxS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:53:18 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2131969fgg.17
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4426o57AXpf2DO2pISvfTX+qIEKbJd2cJceerT0jlZI=;
        b=RUrWwyqA+fD7fclMS55RK1D84GzmASDVLQzsOOW3b+Bxn9pPUOMaR2X6Ck9MOplG1u
         8ctDclOgpjDw1qg/iQ3jv26H/9M3I2NgdobKs5wNzCJ4DJoGVI89WmrKlz9Zz6T13oUJ
         ccqo9d1tZPLVjHAuwgYKdE6yqzw5ghVnYjgYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H/Xo/q7mJWJHnNulPiOvrQevPbWWw+Du0O+ypgNRaN2xst7m9t7RHL3Mh+9YKkUwhc
         rfHqe1M/sySO/0SaGf6vOqVoFnCgYnCTPV5AXw9F3Nh8u9Qc5t1Ttnuo8nYUxt8c4FMo
         kGQnGwQU6AteESwXZ9lrJWDFnluHigp7HDuyY=
Received: by 10.86.70.3 with SMTP id s3mr1394892fga.78.1235177596739; Fri, 20 
	Feb 2009 16:53:16 -0800 (PST)
In-Reply-To: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110918>

On Sat, Feb 21, 2009 at 2:49 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This patch series is the first of a two parts reorganization for more
> maintainability and user friendliness.

Err, the second.

-- 
Felipe Contreras
