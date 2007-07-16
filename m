From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 0/6] Introduce commit notes
Date: Mon, 16 Jul 2007 08:57:46 +0100
Message-ID: <200707160857.48725.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alberto Bertogli <albertito@gmail.com>, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 09:57:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IALSv-000792-Lh
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 09:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbXGPH5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 03:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbXGPH5y
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 03:57:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:6034 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbXGPH5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 03:57:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so925917ugf
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 00:57:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NAGa3KB9KOkyPKo2ADszYZMJTog1gUmD9Tp/ajXG39S5vClLXdtwpA5Zj0otz/kzaZTTox3V7JV7/OsnTvphjv457Qvqe4iHQpOTLzn1501ZxtxgClvb02qY24U4YXF7/8yneDm4LcdBCldC6TgqMPh8twgfazVTp/bdcatSJ8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HtWF3Qe4lLCRArHQGmW1PAIgsWV91C6hvLOwmHQymRHvPYN0VjyTSfZNHhTKjrNbDz6shpmjCxlDiLns9O3XbS5epqAVEEjecjLgmFMn2Vm7jdyh8LI+auYMc9eqvxG5M82Y7lgJCFnqzrchev8fpguthNO45VHwvsVkm2MY768=
Received: by 10.67.22.14 with SMTP id z14mr4140768ugi.1184572672133;
        Mon, 16 Jul 2007 00:57:52 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm45411109ika.2007.07.16.00.57.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jul 2007 00:57:51 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0707152326080.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52648>

On Monday 2007 July 16, Johannes Schindelin wrote:

> The biggest obstacle was a thinko about the scalability.  Tree objects
> take free form name entries, and therefore a binary search by name is not
> possible.

I might be misunderstanding, but in the case of the notes tree objects isn't 
it true that the name entries aren't free form, but are guaranteed to be of a 
fixed length form:

  XX/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

In which case you can binary search?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
