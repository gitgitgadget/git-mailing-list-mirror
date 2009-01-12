From: mark <markkicks@gmail.com>
Subject: Re: git log, outputs something weird for colors
Date: Mon, 12 Jan 2009 14:38:42 -0800
Message-ID: <82fa9e310901121438t7f525c60nfc91bcdc89c97e26@mail.gmail.com>
References: <82fa9e310901121351y22feaf21rfb880bcd0d6cb1a3@mail.gmail.com>
	<8c9a060901121428j37ff6699g7af264f79829b6de@mail.gmail.com>
	<82fa9e310901121433p67f7bb3ai330439bf3c00df26@mail.gmail.com>
Reply-To: kde@mail.kde.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, kde@mail.kde.org
To: "Jacob Helwig" <jacob.helwig@gmail.com>
X-From: kde-bounces-+kde-kde=m.gmane.org@mail.kde.org Mon Jan 12 23:40:51 2009
Return-path: <kde-bounces-+kde-kde=m.gmane.org@mail.kde.org>
Envelope-to: kde-kde@gmane.org
Received: from ktown.kde.org ([131.246.120.250])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1LMVSj-0002wH-4n
	for kde-kde@gmane.org; Mon, 12 Jan 2009 23:40:49 +0100
Received: (qmail 14747 invoked by uid 72); 12 Jan 2009 22:39:25 -0000
Received: (qmail 14724 invoked from network); 12 Jan 2009 22:39:23 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on ktown.kde.org
Received: from unknown (HELO rv-out-0506.google.com) (209.85.198.231)
	by ktown.kde.org with SMTP; 12 Jan 2009 22:39:21 -0000
Received: by rv-out-0506.google.com with SMTP id b25so12389327rvf.43
	for <kde@mail.kde.org>; Mon, 12 Jan 2009 14:38:42 -0800 (PST)
Received: by 10.114.155.1 with SMTP id c1mr19793985wae.174.1231799922725;
	Mon, 12 Jan 2009 14:38:42 -0800 (PST)
Received: by 10.114.59.17 with HTTP; Mon, 12 Jan 2009 14:38:42 -0800 (PST)
In-Reply-To: <82fa9e310901121433p67f7bb3ai330439bf3c00df26@mail.gmail.com>
Content-Disposition: inline
X-BeenThere: kde@mail.kde.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: General KDE discussion <kde.mail.kde.org>
List-Unsubscribe: <https://mail.kde.org/mailman/listinfo/kde>,
	<mailto:kde-request@mail.kde.org?subject=unsubscribe>
List-Post: <mailto:kde@mail.kde.org>
List-Help: <mailto:kde-request@mail.kde.org?subject=help>
List-Subscribe: <https://mail.kde.org/mailman/listinfo/kde>,
	<mailto:kde-request@mail.kde.org?subject=subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105406>

On Mon, Jan 12, 2009 at 2:33 PM, mark <markkicks@gmail.com> wrote:
> On Mon, Jan 12, 2009 at 2:28 PM, Jacob Helwig <jacob.helwig@gmail.com> wrote:
>> On Mon, Jan 12, 2009 at 13:51, mark <markkicks@gmail.com> wrote:
>>> hi
>>> i am using kde konsole, and i am getting weird output for colors, for
>>> example for git log i get the following output
>>>
>>>
>>> git log
>>> ESC[33mcommit 8b918256d944221f741e5d7300873810e31466a6ESC[m
>>>
>>>
>>> settings in my bash and git.
>>>
>>> export | grep -i term
>>> declare -x TERM="xterm-256color"
>>>
>>>
>>> ~/.gitconfig
>>> [color]
>>>  branch = auto
>>>  diff = auto
>>>  status = auto
>>>
>>> do you know what is wrong?
>>> thanks
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> I don't have any problems with Konsole and git's coloring, but my TERM
>> is set to "xterm", not "xterm-256color".
>
> even xterm does not work for me!
> but git status, and git branch give the correct color. the problem is
> only with git log!
>
this helped!

http://git.or.cz/gitwiki/GitFaq#head-678310c22f3e4a233d348bdde55a3e4cb7368ee9

i had LESS=-Q set on my .bashrc, commenting that out produces nice
colors for git log!
thanks all!
___________________________________________________
This message is from the kde mailing list.
Account management:  https://mail.kde.org/mailman/listinfo/kde.
Archives: http://lists.kde.org/.
More info: http://www.kde.org/faq.html.
