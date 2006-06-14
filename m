From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-diff --cc broken in 1.4.0?
Date: Thu, 15 Jun 2006 08:58:28 +1200
Message-ID: <46a038f90606141358l5ee4f8abv207b68dc534ce02c@mail.gmail.com>
References: <46a038f90606112132jaf33a25x5794a19db2a06d8d@mail.gmail.com>
	 <7vmzcfcwb5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 22:58:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqcRc-0001CL-8k
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 22:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWFNU6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 16:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWFNU6a
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 16:58:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:22672 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932301AbWFNU63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 16:58:29 -0400
Received: by wr-out-0506.google.com with SMTP id 36so222617wra
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 13:58:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q/Cv48w1Gh18YcqG7jqUkztEZdr23pzA5SYz8aM4SrX+CNys7+JrNkNIr0iqJ2YYCZfQ/5+tsMvLTDb9Xa7vjrR1xUCIZXGH1OyobanzE2DDoEYBep0lTtjmCMoER39+wz6/5DucyebVVWM5nd5QwahA48wJ9VL9i5+w5IJiIXk=
Received: by 10.54.98.5 with SMTP id v5mr1007628wrb;
        Wed, 14 Jun 2006 13:58:28 -0700 (PDT)
Received: by 10.54.71.9 with HTTP; Wed, 14 Jun 2006 13:58:28 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vmzcfcwb5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21862>

On 6/15/06, Junio C Hamano <junkio@cox.net> wrote:
> One thing to note is that --cc does not show a hunk in which you
> take only from one side.

Must have been that. I was looking at a big (but clean) merge, and
where gitk used to show a large-ish diff there was nothing. I somehow
expected an even larger diff with the changes against both sides.

thanks for the clarification and sorry about that!



m
