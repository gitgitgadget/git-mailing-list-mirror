From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Wed, 8 Dec 2010 18:02:40 -0800
Message-ID: <192758EC-4276-445D-B1D5-284073D5AB32@sb.org>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <201012082051.09730.jnareb@gmail.com> <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com> <201012090254.24999.jnareb@gmail.com> <20101209015926.GA31119@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 03:03:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQVqb-0000lF-JF
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 03:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173Ab0LICCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 21:02:47 -0500
Received: from mail-px0-f179.google.com ([209.85.212.179]:40576 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168Ab0LICCq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 21:02:46 -0500
X-Greylist: delayed 106261 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2010 21:02:46 EST
Received: by pxi20 with SMTP id 20so565760pxi.10
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 18:02:46 -0800 (PST)
Received: by 10.142.131.4 with SMTP id e4mr3397967wfd.441.1291860165854;
        Wed, 08 Dec 2010 18:02:45 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w22sm1686981wfd.7.2010.12.08.18.02.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 18:02:44 -0800 (PST)
In-Reply-To: <20101209015926.GA31119@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163257>

On Dec 8, 2010, at 5:59 PM, Jonathan Nieder wrote:

> Jakub Narebski wrote:
> 
>> You would need HEAD{^{/foo}^@}x3, or use special rule that HEAD^{/foo}x2
>> means really HEAD^{/foo}^@^{/foo}, with ^@ used to join them.
> 
> That said, does ^2x500 really do something meaningful that a person
> would ever need?  I like the
> 
> 	^{:nth(3)/foo}
> 
> syntax because perl6 supports m:nth(3)/foo/, suggesting a menu of
> already-defined modifiers to implement when they prove useful, known
> already to a certain subset of the audience and proven useful already
> in a different context.

I like the ^{:nth(3)/foo} syntax as well. Though I'm not familiar with Perl 6,
this does have the benefit of being fairly obvious to the reader as to what it
means.

-Kevin Ballard