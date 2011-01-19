From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: core.whitespace space-in-indent feature request
Date: Wed, 19 Jan 2011 11:53:17 +0100
Message-ID: <4A1964D5-609C-418B-BDEF-F5B52EC98F95@terreactive.ch>
References: <AANLkTikiHXofGVg9QECg9a4U4r4VGD1tb6oMV21nzd9W@mail.gmail.com> <1295380297.3778.47.camel@drew-northup.unet.maine.edu> <20205598.46894.1295382705010.JavaMail.trustmail@mail1.terreactive.ch> <3798749.47565.1295432145824.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@terreactive.ch>
X-From: git-owner@vger.kernel.org Wed Jan 19 11:53:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfVfO-0006WM-9a
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 11:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab1ASKxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 05:53:25 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:57722 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab1ASKxZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jan 2011 05:53:25 -0500
In-Reply-To: <3798749.47565.1295432145824.JavaMail.trustmail@mail1.terreactive.ch>
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165261>

On Jan 19, 2011, at 10:42 AM, Victor Engmark wrote:

> On Jan 18, 2011, at 9:31 PM, Junio C Hamano wrote:
> 
>> Drew Northup <drew.northup@maine.edu> writes:
>> 
>>> On Fri, 2011-01-14 at 13:40 +0100, Victor Engmark wrote:
>>>> Hi all,
>>>> 
>>>> I couldn't find this mentioned anywhere, but it would be useful for
>>>> languages where you typically want only tab characters in indentation,
>>>> like makefiles. Would be equivalent or similar to indent-with-non-tab
>>>> and tabwidth=1.
>>> 
>>> Victor,
>>> What would the point of this be? Git doesn't change the layout of the
>>> code when storing it--that's up to the thing between the chair and the
>>> keyboard.
>> 
>> True, but I think Victor wants to be able to ask "diff --check" to
>> complain and diff --color to highlight when it sees a line that begins
>> with a SP (or a HT then SP) by setting:
>> 
>> 	* whitespace=space-in-indent
>> 
>> or something in the attributes file.
>> 
>> As "equivalence" exists, not very much interested in coding it myself,
>> though ;-)
> 
> That's it, but it turns out the settings don't work the way I expected:
> 
> $ git config --add core.whitespace 'indent-with-non-tab,tabwidth=1'
> $ touch whitespace.txt
> $ git add whitespace.txt
> [Add the following to the file]
> 	HT
> SP
> 	SP HT
> 	 HT SP
> 2 SP
> 		2 HT
>       8 SP

Bloody OS X Mail - All those lines should of course be indented with the characters indicated at the end of the line.

Cheers,
-- 
Victor