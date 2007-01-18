From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Thu, 18 Jan 2007 15:00:16 +0000
Message-ID: <200701181500.17970.andyparkins@gmail.com>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AF5F83.6090207@fs.ei.tum.de> <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 18 16:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Ykc-0003Yt-Lc
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbXARPAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbXARPAZ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:00:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:46313 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbXARPAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:00:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so196848uga
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 07:00:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=O24TCcGt+klzM0ov2jNWzeUjhTkOfTu9cWiasxMCvmASsow+69Y2tmn4jHCY6fsNAvep1X9jyYR/tTAy09NZs4M7KxbHLONjEzOZVoKQS8xj5U8GfbgfPfAX2iyLgrwSZgJuB0uK/IvbL7eilZg8/vqxT0EeHzSznBp7Za+15LQ=
Received: by 10.67.96.14 with SMTP id y14mr1405538ugl.1169132422201;
        Thu, 18 Jan 2007 07:00:22 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id 55sm1106553ugq.2007.01.18.07.00.20;
        Thu, 18 Jan 2007 07:00:21 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37101>

On Thursday 2007 January 18 13:57, Johannes Schindelin wrote:

I think this would be clearer if next were renamed...

> +struct commit_list *reverse_commit_list(struct commit_list *list)
> +{
> +	struct commit_list *prev = NULL, *current, *backup;
> +	for (current = list; current; current = backup) {
> +		backup = current->next;
> +		current->next = prev;
> +		prev = current;
> +	}
> +	return next;
> +}

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
