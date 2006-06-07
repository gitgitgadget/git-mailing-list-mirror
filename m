From: "Igor Bukanov" <igor.bukanov@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Wed, 7 Jun 2006 11:02:55 +0200
Message-ID: <df0b33100606070202w581ff581i435056f0fbc197f8@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149214075.5521.31.camel@neko.keithp.com>
	 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
	 <1149219593.5521.34.camel@neko.keithp.com>
	 <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
	 <1149220518.5521.43.camel@neko.keithp.com>
	 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
	 <20060602041107.GA5429@spearce.org> <1149223164.2443.33.camel@dv>
	 <9e4733910606012144p5f4fda26sdc2de2cc77b71fe7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski@gnu.org>,
	"Shawn Pearce" <spearce@spearce.org>,
	"Keith Packard" <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 11:03:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fntwc-0005Hz-TP
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 11:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWFGJC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 05:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWFGJC5
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 05:02:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:18316 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751141AbWFGJC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 05:02:56 -0400
Received: by ug-out-1314.google.com with SMTP id h2so193891ugf
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 02:02:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fxTOmJUAo95eOsT3ExhzduWbNMGTn7XWhypoD1Wye6GXPkejxg/1ODwHWnIjPfbNkra6c4YQ09kIk7mo6812SnUeHJ2oQgvRCQEIXZiK6n8CN16pjK0j/Lon5R+SeUE8/VnfK7wJpEZ8BMvzLDECyttbcFQFNWYcjjYYpMtksww=
Received: by 10.78.45.13 with SMTP id s13mr54173hus;
        Wed, 07 Jun 2006 02:02:55 -0700 (PDT)
Received: by 10.78.18.9 with HTTP; Wed, 7 Jun 2006 02:02:55 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606012144p5f4fda26sdc2de2cc77b71fe7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21434>

On 6/2/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/2/06, Pavel Roskin <proski@gnu.org> wrote:
> > Dependency on Cygwin, Perl and Python is too much.  Windows is becoming
> > a legacy system in some circles, and it may run on legacy hardware.  Yet
> > it's irreplaceable as a testing platform for many projects.
>
> 80% of Mozilla commiters are running Windows. Some are OS bilingual
> but many are not.

Mozilla build system on Windows requires Cygwin and there are 198 Perl
files in Firefox tree. So it is only Python that can be problematic.

Regards, Igor
