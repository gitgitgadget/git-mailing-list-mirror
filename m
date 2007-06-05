From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: Re: Improved git-gui blame viewer
Date: Tue, 05 Jun 2007 23:47:21 +0200
Message-ID: <4665D9E9.8050409@xs4all.nl>
References: <20070602041723.GD7044@spearce.org> <f3rhme$2h9$1@sea.gmane.org> <20070604060720.GF4507@spearce.org> <4664838C.8000109@xs4all.nl> <20070605042855.GA9513@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 23:47:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvgsQ-0000rt-VR
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 23:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760775AbXFEVrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 17:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761428AbXFEVrb
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 17:47:31 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:4228 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760775AbXFEVra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 17:47:30 -0400
Received: from [10.0.0.3] (zwaan.xs4all.nl [213.84.190.116])
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id l55LlLHi032690;
	Tue, 5 Jun 2007 23:47:27 +0200 (CEST)
	(envelope-from mmelchior@xs4all.nl)
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <20070605042855.GA9513@spearce.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49229>

Shawn O. Pearce wrote:
> Matthijs Melchior <mmelchior@xs4all.nl> wrote:
>   
>> Shawn O. Pearce wrote:
>>     
>>> I'm not sure I understand what you are looking for here.  Right now
>>> git-gui should be inverting the foreground/background colors on
>>> the file that is "selected" (shown in the lower diff view pane).
>>> So the background should be black, and the foreground white.
>>> Is this not happening?  Or are you looking for something else?
>>>
>>>       
>> No, I am not looking for something else...., the inverting you describe
>> does not happen on my machine....
>>     
>
> I'm wrong.  Its not inverting.  Its bold if its selected, and normal
> if its not selected.  Perhaps your font is already a bold weight
> so you aren't seeing a difference between the selected item and
> the non-selected items.
>  
>   
>> I am now running Debian git-core 1.5.2.1-1 with 'make install' done
>> in the origin/pu branch of git-gui.
>> 'About git-gui' now says:
>> 	git-gui version 0.7.2.58-gf9e9
>> 	git version 1.5.2.1
>> 	Tcl/Tk version 8.4.12
>>
>> If you explain where this inverting is taking place, I can do some
>> experiments to find out more [use gray background i.s.o. inverting...]
>> Maybe it has something to do with Desktop themes, I use the standard
>> Gnome theme.
>>     
>
> Around line 1803 of git-gui.sh we setup the in_diff tag for the
> $ui_index and $ui_workdir Tk widgets.  That tag is applied to the
> file that is in the diff viewer.  Perhaps adding a background to
> the tag would get you an improved interface?
>   
Yes, this is the problem.

I will send you a patch to change the background of the selected file
to lightgray.

I have included in that patch some softer colors for the headers of
the three involved widgets. I hope you like these.

Thanks.

-- 
Regards,
----------------------------------------------------------------  -o)
Matthijs Melchior                                       Maarssen  /\\
mmelchior@xs4all.nl                                  Netherlands _\_v
---------------------------------------------------------------- ----
