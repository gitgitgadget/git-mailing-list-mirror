From: Ittay Dror <ittayd@tikalk.com>
Subject: Re: merge renamed files/directories?
Date: Sun, 04 May 2008 09:08:12 +0300
Message-ID: <481D52CC.1030503@tikalk.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com>	 <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com>	 <20080501153457.GB11469@sigill.intra.peff.net>	 <D0968007-2A38-44DB-B26F-3D273F20D428@midwinter.com>	 <20080501231427.GD21731@sigill.intra.peff.net>	 <481CA742.4080909@tikalk.com> <32541b130805031111r4cbea8e1l19c34ac05016a89b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 08:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsXPV-0001rp-60
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 08:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbYEDGIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 02:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbYEDGIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 02:08:16 -0400
Received: from smtp107.biz.mail.re2.yahoo.com ([206.190.52.176]:41230 "HELO
	smtp107.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751231AbYEDGIP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2008 02:08:15 -0400
Received: (qmail 15855 invoked from network); 4 May 2008 06:08:14 -0000
Received: from unknown (HELO ?10.10.2.7?) (ittayd@tikalk.com@212.143.191.180 with plain)
  by smtp107.biz.mail.re2.yahoo.com with SMTP; 4 May 2008 06:08:14 -0000
X-YMail-OSG: dPol5RkVM1nGr7fEeXYZR04h1pPZoZW.NqIZmCaVLGtNSTqUnCXROrcppnTHScaRb8oE0enoN3hGNMK1Z64_k4fZ.tKdV.tUwmt4MX8PQTet_9I.buYBRMD9jcpdbVsiMYWjpvVJMjXv4L7rIyXez.gU
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <32541b130805031111r4cbea8e1l19c34ac05016a89b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81147>



Avery Pennarun wrote:
> Git already works fine for renames.  The only situation where
> something funny happens is if you rename a whole directory and someone
> else creates a file in the old directory.  (In that case, the new file
> ends up in the old place instead of the new place.)  However, even in
> that case, there is still no conflict and no manual merging necessary.
>
>   
Sorry, but this is not the situation as I have experienced it with a 
local repository I have. I renamed a directory (without changing any 
files in it). 'git diff <commit>^ <commit>' shows the rename fine, but 
'git log -p -M -C <initial commit>..' does not (that is, the history for 
files in that directory is shown from the rename commit only). Obviously 
git-diff is not any better.
> In fact, as someone else pointed out, renaming a java file requires
> you to modify the file anyhow, so having git auto-move the file to
> another directory *still* wouldn't make it work any better.
>
>   
Sure it will, because otherwise I need to move it and still need to fix 
it. And there are many other file formats and languages where such a 
move will not require any change (I think it is funny that Java is a 
justification for not doing something for a tool primarily used by C 
people). Also, what happens if I change the file in the new location and 
someone else changes it in the old location? Will I need to do a manual 
merge?

-- 
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
