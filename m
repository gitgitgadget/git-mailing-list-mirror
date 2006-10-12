From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC] separate .git from working directory
Date: Thu, 12 Oct 2006 15:03:25 +0200
Message-ID: <81b0412b0610120603v5a1f661cp36e6d3679cef238b@mail.gmail.com>
References: <200610121415.03086.scallegari@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 15:03:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY0Dl-00016q-Tv
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 15:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWJLND1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 09:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWJLND1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 09:03:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:5131 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751380AbWJLND0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 09:03:26 -0400
Received: by ug-out-1314.google.com with SMTP id o38so281205ugd
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 06:03:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NnftwvJWVQr5WCY66LtqwcmeQIShlfGwj4n8KQZla9icoFvxfHh1EG9zvdc0yglC/1NmVeUoe+yJ04Q0sEpwAhr986V8JsA+Z5neWJCpu71tBo9yDA6BulwG0nsp1UxWL6nI3MQrx14nN/z3/71v9JAwifmugj0CGQnGTupi5UE=
Received: by 10.78.97.7 with SMTP id u7mr2187956hub;
        Thu, 12 Oct 2006 06:03:25 -0700 (PDT)
Received: by 10.78.115.8 with HTTP; Thu, 12 Oct 2006 06:03:24 -0700 (PDT)
To: "Sergio Callegari" <scallegari@arces.unibo.it>
In-Reply-To: <200610121415.03086.scallegari@arces.unibo.it>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28778>

On 10/12/06, Sergio Callegari <scallegari@arces.unibo.it> wrote:
> 1) It might make the life easier on platforms where symlinks are not the
> easiest thing to do (are there any?)

yes. The most widespread one, for a start.
