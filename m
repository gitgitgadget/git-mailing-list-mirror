From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 3 May 2006 23:42:45 +1200
Message-ID: <46a038f90605030442k5c4eee9dj25d4a467942b0f74@mail.gmail.com>
References: <445865A5.5030700@lumumba.uhasselt.be>
	 <46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com>
	 <46a038f90605030411o29af1d1bra3276353347516f6@mail.gmail.com>
	 <445895AC.6070109@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 13:42:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbFkm-0000st-OS
	for gcvg-git@gmane.org; Wed, 03 May 2006 13:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWECLmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 07:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWECLmq
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 07:42:46 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:54394 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965155AbWECLmp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 07:42:45 -0400
Received: by wr-out-0506.google.com with SMTP id 67so113635wri
        for <git@vger.kernel.org>; Wed, 03 May 2006 04:42:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F4TfMTImyZpfr1Yx51H7nUL/rRjMElpsV4Mu3v5ZrobifTHD84jmO5oD9eb4uPhHB1BLFg04dIYYXn/XDBAP2j7FYciEN82LWMvnh0eiJMk21oXYDQI0AwgClR7r4A43eYliXQhsAqDP004lMgisUSZCKUPjimYtOH/fxUeWH+I=
Received: by 10.54.93.20 with SMTP id q20mr984913wrb;
        Wed, 03 May 2006 04:42:45 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Wed, 3 May 2006 04:42:45 -0700 (PDT)
To: "Panagiotis Issaris" <takis@lumumba.uhasselt.be>
In-Reply-To: <445895AC.6070109@lumumba.uhasselt.be>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19473>

On 5/3/06, Panagiotis Issaris <takis@lumumba.uhasselt.be> wrote:
> Yes, I installed 1.3.0 using "make prefix=/tmp/testje install"
> but, I'm getting the same problem (other then my failing typing
> skills ;-) :

The problem is that, while you are executing git-cvsserver from
/tmp/testje, git-cvsserver invokes git-log from the path, and that is
the "bad" git-log. Change your PATH in .bashrc so that the /tmp/testje
install takes precedence...

cheers,


martin
