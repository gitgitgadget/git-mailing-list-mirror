From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 05/12] send-email: Improve redability and 
	error-handling in send_message's sendmail code
Date: Sat, 18 Apr 2009 21:43:58 -0500
Message-ID: <b4087cc50904181943t71d501a6r51bb4cc846f32f78@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
	 <76718490904181851g2701ce59x614ea60452b914ce@mail.gmail.com>
	 <b4087cc50904181913g117937le333c3b255f7d184@mail.gmail.com>
	 <18071eea0904181917u7c7187bubc8fab6ede2d19ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 04:46:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvN2x-00044d-03
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 04:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759983AbZDSCoD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2009 22:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759973AbZDSCoA
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 22:44:00 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:43588 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759902AbZDSCn7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 22:43:59 -0400
Received: by qw-out-2122.google.com with SMTP id 5so568969qwd.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 19:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VQe3a8xh84hLXd3EkWcDQswPupiceetrfeKu5Vva2ZI=;
        b=t4AfMCuGkBZMDQg572yLayJg40xDQ+vTytLBpjttTtAIawAvoN7ZXzVW7LuyEhY8Ay
         V5ZKxTy7Xkoydyty9vuftmzV1YsZGP/Ieq9xa703rcYAOrGtdIe91CSAgevWAtvEME3H
         NiVvkdxEwbx7hX13AjmHJvQQog0u0hTmyxMyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WKH7ZYmbxSfGL9os/tlWfEY6AVURx6f6lAo8m0nXFi9O6pQSFGKxLUzd4CxtFF00Cm
         dUf/X6tWgcxTtubqm75T9h6xVpSQA4nd/KeuDQV0lr4jl/XbWy3dyhpxc+0hP7rl/Wlk
         A0oAuqvQa5cpyTIudmJeoXMuwIUkTEIrDe/Zo=
Received: by 10.224.74.6 with SMTP id s6mr5173953qaj.327.1240109038618; Sat, 
	18 Apr 2009 19:43:58 -0700 (PDT)
In-Reply-To: <18071eea0904181917u7c7187bubc8fab6ede2d19ef@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116879>

On Sat, Apr 18, 2009 at 21:17, Thomas Adam <thomas.adam22@gmail.com> wr=
ote:
> More concerning is that it's a perl 5.10ism -- you cannot assume that
> perl 5.10 is installed on all platforms. =A0I really wouldn't use thi=
s
> construct.

See that's the thing: How am I supposed to know it's a perl 5.10ism?
The Perl docs give absolutely no clue; Perl[5] is based way too much
on practice rather than theory, because only people that have been
using it since day 1 know what's going on. A couple of weeks ago, I
went to the perldoc website and just read each website one after the
other---that is my total knowledge of Perl, and already I've caught
flack a number of times for having used 'new-fangled technologies'; I
really wish the docs would specify when a feature became available.

=2E.. add that to the list of perldoc shortcomings.
