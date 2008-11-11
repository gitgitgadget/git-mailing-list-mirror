From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: git commit -v does not removes the patch
Date: Tue, 11 Nov 2008 08:56:34 +0100
Message-ID: <adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com>
	 <20081110181023.GA22753@coredump.intra.peff.net>
	 <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com>
	 <7vej1j40x5.fsf@gitster.siamese.dyndns.org>
	 <20081111000706.GA26223@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 08:58:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzo8L-0001ZJ-0Q
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 08:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbYKKH4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 02:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbYKKH4i
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 02:56:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:36465 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbYKKH4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 02:56:37 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1303913nfc.21
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 23:56:35 -0800 (PST)
Received: by 10.103.243.9 with SMTP id v9mr4315273mur.5.1226390195037;
        Mon, 10 Nov 2008 23:56:35 -0800 (PST)
Received: by 10.103.165.1 with HTTP; Mon, 10 Nov 2008 23:56:34 -0800 (PST)
In-Reply-To: <20081111000706.GA26223@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100628>

On Tue, Nov 11, 2008 at 1:07 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 10, 2008 at 03:27:18PM -0800, Junio C Hamano wrote:
>
>> > It is exactly as you described. I'll try in other systems.
>>
>> Guess in the dark... by any chance are you enabling color unconditionally?
>
> I thought I covered that case explicitly...
>
> ...yes, I can't reproduce with color set to "always". And indeed,
> looking at the diff for 4f672ad shows that we always turn off color for
> the message that goes to the editor (since we can't trust our isatty
> setting _anyway_, since we're not going to the tty).
>
> So that's not it.

Almost! I have diff.mnemonicprefix=true, if I unset it everything works.

Santi
